import 'dart:async';

import 'package:adaptive_app_demos/pages/home_page.dart';
import 'package:adaptive_app_demos/pages/login_page.dart';
import 'package:adaptive_app_demos/pages/unknown_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'application_state.dart';
import 'firebase_options.dart';
import 'routes.dart' as routes;

final rootNavKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => EasyQuoteApp(),
    ),
  );
}

class EasyQuoteApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) async {
    _EasyQuoteAppState? state = context.findAncestorStateOfType<_EasyQuoteAppState>();
    state?.changeLanguage(newLocale);
  }

  @override
  State<EasyQuoteApp> createState() => _EasyQuoteAppState();
}

class _EasyQuoteAppState extends State<EasyQuoteApp> {
  late StreamSubscription<User?> _auth;
  final _navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance.userChanges().listen((event) {
      _navigatorKey.currentState!.pushReplacementNamed(
        event != null ? 'home' : 'login',
      );
    });
  }

  @override
  void dispose() {
    _auth.cancel();
    super.dispose();
  }

  ///////////////Change Language//////////////////////////////
  late Locale _locale = const Locale('zh', '');

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    final appState = Provider.of<ApplicationState>(context);
    if (appState.userProfile.locale != null) {
      if (appState.userProfile.locale == "zh") {
        setState(() {
          _locale = const Locale('zh');
        });
      }
      if (appState.userProfile.locale == "en") {
        setState(() {
          _locale = const Locale('en');
        });
      }
    }
  }
  ///////////////Change Language//////////////////////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      restorationScopeId: 'root',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        // visualDensity: density,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant',
            countryCode: 'HK'), // Spanish, no country code
      ],
      initialRoute:
      FirebaseAuth.instance.currentUser == null ? 'login' : 'home',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'home':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => HomePage(),
            );
          case 'login':
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => LoginPage(),
            );
          default:
            return MaterialPageRoute(
              settings: settings,
              builder: (_) => UnknownPage(),
            );
        }
      },
    );
  }
}

//
// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'pages/home_page.dart';
// import 'pages/login_page.dart';
// import 'pages/unknown_page.dart';
// import 'application_state.dart';
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ApplicationState(),
//       builder: (context, _) => EasyQuoteApp(),
//     ),
//   );
// }
//
// class EasyQuoteApp extends StatefulWidget {
//
//   @override
//   State<EasyQuoteApp> createState() => _EasyQuoteAppState();
// }
//
// class _EasyQuoteAppState extends State<EasyQuoteApp> {
//   late StreamSubscription<User?> _auth;
//   final _navigatorKey = new GlobalKey<NavigatorState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _auth = FirebaseAuth.instance.userChanges().listen((event) {
//       _navigatorKey.currentState!.pushReplacementNamed(
//         event != null ? 'home' : 'login',
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _auth.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Give your RootRestorationScope an id, defaults to null.
//       restorationScopeId: 'root',
//       navigatorKey: _navigatorKey,
//       // initialRoute: 'home',
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
