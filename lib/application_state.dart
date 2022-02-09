import 'dart:async';
import 'package:adaptive_app_demos/global/device_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'models/guestbook_message.dart';
// import 'View/yes_no_session.dart';
import 'authentication.dart';

///////////////////////////////////////////////////////////
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        print("UID: ${user.uid}");
        _loginState = ApplicationLoginState.loggedIn;

        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          snapshot.docs.forEach((document) {
            _guestBookMessages.add(
              GuestBookMessage(
                name: document.data()['name'] as String,
                message: document.data()['text'] as String,
              ),
            );
          });
          notifyListeners();
        });

        // _attendingSubscription = FirebaseFirestore.instance
        //     .collection('attendees')
        //     .doc(user.uid)
        //     .snapshots()
        //     .listen((snapshot) {
        //   if (snapshot.data() != null) {
        //     if (snapshot.data()!['attending'] as bool) {
        //       _attending = Attending.yes;
        //     } else {
        //       _attending = Attending.no;
        //     }
        //   } else {
        //     _attending = Attending.unknown;
        //   }
        //   notifyListeners();
        // });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
        _attendingSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  StreamSubscription<DocumentSnapshot>? _attendingSubscription;

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  int _attendees = 0;
  int get attendees => _attendees;

  // Attending _attending = Attending.unknown;
  // Attending get attending => _attending;

  // set attending(Attending attending) {
  //   final userDoc = FirebaseFirestore.instance
  //       .collection('attendees')
  //       .doc(FirebaseAuth.instance.currentUser!.uid);
  //   if (attending == Attending.yes) {
  //     userDoc.set(<String, dynamic>{'attending': true});
  //   } else {
  //     userDoc.set(<String, dynamic>{'attending': false});
  //   }
  // }

/////////////////////////////////////////////////////
  bool getDefaultTouchMode() => DeviceType.isMobile == true;

  // Main menu, selected page
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) => notify(() => _selectedIndex = value);

  // Touch mode, determines density of views
  late bool _touchMode = getDefaultTouchMode();
  bool get touchMode => _touchMode;
  set touchMode(bool value) => notify(() => _touchMode = value);

  void toggleTouchMode() => touchMode = !touchMode;
/////////////////////////////////////////////////////

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void registerAccount(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => addNewUser(email));
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void sendVerificationEmail(
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  ////////////////////////////////////////////////////////
  CollectionReference<Map<String, dynamic>> addNewUser(String email) {
    var collection = FirebaseFirestore.instance.collection('users');
    collection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'email': email,
          'id': FirebaseAuth.instance.currentUser!.uid
        })
        .then((_) => print('Added'))
        .catchError((error) => print('Add failed: $error'));
    return (collection);
  }

  void registerAccountAndDisplayName(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  /////////////////////////////////////////////////////
  // Helper method for single-line state changes
  void notify(VoidCallback stateChange) {
    stateChange.call();
    notifyListeners();
  }

  void reset() {
    _selectedIndex = 0;
    _touchMode = getDefaultTouchMode();
  }
/////////////////////////////////////////////////////
}
