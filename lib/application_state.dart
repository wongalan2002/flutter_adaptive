import 'dart:async';
import 'package:adaptive_app_demos/global/device_type.dart';
import 'package:adaptive_app_demos/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'models/guestbook_message.dart';
// import 'View/yes_no_session.dart';
import 'authentication.dart';
import 'models/quotation_item.dart';
import 'models/quotation_order.dart';
import 'models/user_profile.dart';

enum MailboxPageType {
  inbox,
  starred,
  sent,
  trash,
  spam,
  drafts,
}

///////////////////////////////////////////////////////////
class ApplicationState with ChangeNotifier {
  StreamSubscription<QuerySnapshot>? _quotationOrdersSubscription;
  StreamSubscription<DocumentSnapshot>? _userProfileSubscription;
  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  StreamSubscription<DocumentSnapshot>? _attendingSubscription;

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  List<GuestBookMessage> _guestBookMessages = [];
  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  QuotationOrder _quotationOrder =
  QuotationOrder(quotationItems: [], quotationRequester: '');
  QuotationOrder get quotationOrder => _quotationOrder;
  set quotationOrder(QuotationOrder value) {
    _quotationOrder = value;
    print("I am setting QuotationOrder:${_quotationOrder}");
    notifyListeners();
  }

  List<QuotationOrder> _quotationOrders = [];
  List<QuotationOrder> get quotationOrders => _quotationOrders;

  int _attendees = 0;
  int get attendees => _attendees;

  UserProfile _userProfile = UserProfile();
  UserProfile get userProfile => _userProfile;

  set userProfile(UserProfile userProfile) {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    // userDoc.set(<String, dynamic>{
    //   'name': userProfile.name,
    //   'email': userProfile.email,
    //   'schoolName': userProfile.schoolName,
    //   'post': userProfile.post,
    //   'phone': userProfile.phone
    // });
    userDoc.set(userProfile.toJson());
  }
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
  int _selectedMenuIndex = 0;
  int get selectedMenuIndex => _selectedMenuIndex;
  set selectedMenuIndex(int value) {
    _selectedMenuIndex = value;
    print("I am setting _selectedMenuIndex:${_selectedMenuIndex}");
    notifyListeners();
  }

  MailboxPageType _selectedMailboxPage = MailboxPageType.inbox;
  MailboxPageType get selectedMailboxPage => _selectedMailboxPage;
  set selectedMailboxPage(MailboxPageType mailboxPage) {
    _selectedMailboxPage = mailboxPage;
    notifyListeners();
  }

  bool _onSearchPage = false;
  bool get onSearchPage => _onSearchPage;
  set onSearchPage(bool value) {
    _onSearchPage = value;
    notifyListeners();
  }


  // Touch mode, determines density of views
  late bool _touchMode = getDefaultTouchMode();
  bool get touchMode => _touchMode;
  set touchMode(bool value) => notify(() => _touchMode = value);

  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
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

        _quotationOrdersSubscription = FirebaseFirestore.instance
            .collection('quotations')
            .orderBy('submissionDate', descending: true)
            .where('userId', isEqualTo: user.uid)
            .snapshots()
            .listen((snapshot) {
          _quotationOrders = [];
          for (var document in snapshot.docs) {
            _quotationOrders.add(QuotationOrder.fromMap(document.data()));
          }
          notifyListeners();
        });

        _userProfileSubscription = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            _userProfile = UserProfile.fromMap(snapshot.data()!);
          }
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
        _userProfile = UserProfile();
        _quotationOrders = [];
        _guestBookMessages = [];
        _loginState = ApplicationLoginState.loggedOut;

        _guestBookSubscription?.cancel();
        _attendingSubscription?.cancel();
        _userProfileSubscription?.cancel();
        _quotationOrdersSubscription?.cancel();
      }
      notifyListeners();
    });
    // if (FirebaseAuth.instance.currentUser!.emailVerified){
    //
    // }else{
    //   _loginState = ApplicationLoginState.verifyEmail;
    //   final user = FirebaseAuth.instance.currentUser!;
    //   await user.sendEmailVerification();
    //   print("Verify Email");
    // }

    // FirebaseFirestore.instance
    //     .collection('attendees')
    //     .where('attending', isEqualTo: true)
    //     .snapshots()
    //     .listen((snapshot) {
    //   _attendees = snapshot.docs.length;
    //   notifyListeners();
    // });

    // FirebaseAuth.instance.userChanges().listen((user) {
    //   if (user != null) {
    //     print("UID: ${user.uid}");
    //     _loginState = ApplicationLoginState.loggedIn;
    //
    //     _guestBookSubscription = FirebaseFirestore.instance
    //         .collection('guestbook')
    //         .orderBy('timestamp', descending: true)
    //         .snapshots()
    //         .listen((snapshot) {
    //       _guestBookMessages = [];
    //       snapshot.docs.forEach((document) {
    //         _guestBookMessages.add(
    //           GuestBookMessage(
    //             name: document.data()['name'] as String,
    //             message: document.data()['text'] as String,
    //           ),
    //         );
    //       });
    //       notifyListeners();
    //     });
    //
    //     // _attendingSubscription = FirebaseFirestore.instance
    //     //     .collection('attendees')
    //     //     .doc(user.uid)
    //     //     .snapshots()
    //     //     .listen((snapshot) {
    //     //   if (snapshot.data() != null) {
    //     //     if (snapshot.data()!['attending'] as bool) {
    //     //       _attending = Attending.yes;
    //     //     } else {
    //     //       _attending = Attending.no;
    //     //     }
    //     //   } else {
    //     //     _attending = Attending.unknown;
    //     //   }
    //     //   notifyListeners();
    //     // });
    //   } else {
    //     _loginState = ApplicationLoginState.loggedOut;
    //     _guestBookMessages = [];
    //     _guestBookSubscription?.cancel();
    //     _attendingSubscription?.cancel();
    //   }
    //   notifyListeners();
    // });
  }

  void toggleTouchMode() => touchMode = !touchMode;
/////////////////////////////////////////////////////

  // void startLoginFlow() {
  //   _loginState = ApplicationLoginState.emailAddress;
  //   notifyListeners();
  // }

  // void verifyEmail(
  //   String email,
  //   void Function(FirebaseAuthException e) errorCallback,
  // ) async {
  //   try {
  //     var methods =
  //         await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //     if (methods.contains('password')) {
  //       _loginState = ApplicationLoginState.password;
  //     } else {
  //       _loginState = ApplicationLoginState.register;
  //     }
  //     _email = email;
  //     notifyListeners();
  //   } on FirebaseAuthException catch (e) {
  //     errorCallback(e);
  //   }
  // }

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

  // void cancelRegistration() {
  //   _loginState = ApplicationLoginState.emailAddress;
  //   notifyListeners();
  // }

  void registerAccount(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(email: email, password: password)
      //     .then((value) => addNewUser(email));
      // _loginState = ApplicationLoginState.verifyEmail;
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

  bool isEmailVerified() {
    return FirebaseAuth.instance.currentUser!.emailVerified;
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
    selectedMailboxPage = MailboxPageType.inbox;
    selectedMenuIndex = 0;
    _touchMode = getDefaultTouchMode();
  }
/////////////////////////////////////////////////////

  Future<DocumentReference> addQuotationOrder(quotationItems) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }
    return FirebaseFirestore.instance
        .collection('quotations')
        .add(quotationItems);
  }

  Stream<QuerySnapshot> streamImage() {
    return FirebaseFirestore.instance.collection('imageURLs').snapshots();
  }

  addQuotationItem(newValue) {
    _quotationOrder.quotationItems!.add(newValue);
    notifyListeners();
  }

  updateQuotationItem(int index, QuotationItem newValue, bool deleteThis) {
    if (deleteThis == true) {
      _quotationOrder.quotationItems!.removeAt(index);
    } else {
      _quotationOrder.quotationItems![index] = newValue;
    }
    notifyListeners();
  }

  deleteQuotationItem(index) {
    print("Delete at ${index}");
    _quotationOrder.quotationItems!.removeAt(index);
    notifyListeners();
  }

  updateQuotationRequester(value){
    _quotationOrder.quotationRequester = value;
    print(value);
    notifyListeners();
  }
}
