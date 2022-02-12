import 'package:adaptive_app_demos/pages/login_page.dart';
import 'package:adaptive_app_demos/pages/verify_email_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../application_state.dart';
import '../authentication.dart';
import 'verify_email_page.dart';

class MainAppScaffold extends StatefulWidget {
  @override
  _MainAppScaffoldState createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: StreamBuilder<User?>(
  //           stream: FirebaseAuth.instance.authStateChanges(),
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {
  //               print(snapshot.data);
  //               return VerifyEmailPage();
  //             } else {
  //               print("Not Login");
  //               return LoginPage();
  //             }
  //           }));
  // }
  Widget build(BuildContext context) {
    var appState = Provider.of<ApplicationState>(context);
    if (appState.loginState == ApplicationLoginState.loggedIn) {
      return VerifyEmailPage();
    } else {
      print("Not Login");
      return LoginPage();
    }
  }
}
