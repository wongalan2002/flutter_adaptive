import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import 'home_page.dart';
import 'login_detail_panel.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  VerifyEmailPageState createState() => VerifyEmailPageState();
}

class VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResentEmail = false;
  Timer? timer;
  Timer? countDownTimer;
  late int _counter;
  int _start = 60;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      startTimer();
      timer = Timer.periodic(Duration(seconds: 5), (timer) {
        print("5 sec");
        checkEmailVerified();
      });
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    var _email = FirebaseAuth.instance.currentUser!.email.toString();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      context.read<ApplicationState>().addNewUser(_email);
      print("Email verification success");
      timer?.cancel();
    }
  }

  void startTimer() {
    setState(() => canResentEmail = false);
    setState(() => _counter = _start);
    const oneSec = const Duration(seconds: 1);
    countDownTimer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_counter == 0) {
          setState(() {
            timer.cancel();
            setState(() => canResentEmail = true);
          });
        } else {
          setState(() {
            _counter--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    countDownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool useVerticalLayout = screenSize.width < screenSize.height;
    bool hideDetailPanel = screenSize.shortestSide < 250;
    return Material(
      child: Column(
        children: [
          Expanded(
              child: isEmailVerified
                  ? HomePage()
                  : Scaffold(
                      body: Flex(
                          direction: useVerticalLayout
                              ? Axis.vertical
                              : Axis.horizontal,
                          children: [
                            if (hideDetailPanel == false) ...[
                              Flexible(child: LoginDetailPanel()),
                            ],
                            Flexible(
                              flex: useVerticalLayout ? 2 : 1,
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 450),
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "A verification email has been sent to your email ${FirebaseAuth.instance.currentUser!.email}.",
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 8),
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: new TextSpan(
                                              children: [
                                                new TextSpan(
                                                  text: "If this email address is incorrect you can ",
                                                  style: new TextStyle(color: Colors.black),
                                                ),
                                                new TextSpan(
                                                  text: 'start over',
                                                  style: new TextStyle(color: Colors.blue),
                                                  recognizer: new TapGestureRecognizer()
                                                    ..onTap = () {
                                                      FirebaseAuth.instance.signOut();
                                                    },
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                          ElevatedButton(
                                              onPressed: canResentEmail
                                                  ? () {
                                                      sendVerificationEmail();
                                                      startTimer();
                                                    }
                                                  : null,
                                              child: Container(
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(16.0),
                                                child: canResentEmail
                                                    ? Text("Resent Email")
                                                    : Text(
                                                        "Resent Email ($_counter)"),
                                              )),
                                          SizedBox(height: 8),
                                          TextButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      Size.fromHeight(50)),
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                    )),
        ],
      ),
    );
  }
}
