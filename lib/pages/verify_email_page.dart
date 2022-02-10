import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../global/styling.dart';
import 'home_page.dart';
class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  VerifyEmailPageState createState() => VerifyEmailPageState();
}

class VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResentEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
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
      setState(() => canResentEmail = false);
      await Future.delayed(Duration(seconds: 60));
      setState(() => canResentEmail = true);
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: isEmailVerified
                ? HomePage()
                : Scaffold(
              appBar: AppBar(
                backgroundColor: backgroundColor,
                title: Text("Verify Email"),
                elevation: 0,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "A verification email has been sent to your email ${FirebaseAuth.instance.currentUser!.email}",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    icon: Icon(Icons.email),
                    label: Text(
                      "Resent Email",
                    ),
                    onPressed: () {
                      if (canResentEmail) {
                        sendVerificationEmail();
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  TextButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50)),
                      child: Text("Cancel"),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}