// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late StreamSubscription<User?> _sub;
//   final _navigatorKey = new GlobalKey<NavigatorState>();
//
//   @override
//   void initState() {
//     super.initState();
//
//     _sub = FirebaseAuth.instance.userChanges().listen((event) {
//       _navigatorKey.currentState!.pushReplacementNamed(
//         event != null ? 'home' : 'login',
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _sub.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'HelloWorld',
//       navigatorKey: _navigatorKey,
//       initialRoute:
//       FirebaseAuth.instance.currentUser == null ? 'login' : 'home',
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case 'home':
//             return MaterialPageRoute(
//               settings: settings,
//               builder: (_) => HomePage(),
//             );
//           case 'login':
//             return MaterialPageRoute(
//               settings: settings,
//               builder: (_) => LoginPage(),
//             );
//           default:
//             return MaterialPageRoute(
//               settings: settings,
//               builder: (_) => UnknownPage(),
//             );
//         }
//       },
//     );
//   }
// }
//
// class UnknownPage extends StatefulWidget {
//   const UnknownPage({Key? key}) : super(key: key);
//
//   @override
//   _UnknownPageState createState() => _UnknownPageState();
// }
//
// class _UnknownPageState extends State<UnknownPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(color: Colors.red);
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ListView(
//           padding: EdgeInsets.all(32),
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//               },
//               child: Text('Sign Out'),
//             )
//           ],
//         ));
//   }
// }
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ListView(
//           padding: EdgeInsets.all(32),
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signInAnonymously();
//               },
//               child: Text('Sign In'),
//             )
//           ],
//         ));
//   }
// }