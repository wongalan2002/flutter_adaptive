import 'package:adaptive_app_demos/pages/login_page.dart';
import 'package:adaptive_app_demos/pages/main_app_scaffold.dart';
import 'package:adaptive_app_demos/pages/verify_email_page.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'application_state.dart';
import 'authentication.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Required when using bits_dojo for custom TitleBars
  doWhenWindowReady(() {
    appWindow.title = "Easy Quote";
    appWindow.show();
  });

  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => EasyQuoteApp(),
    ),
  );
}

class EasyQuoteApp extends StatefulWidget {
  const EasyQuoteApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) async {
    _EasyQuoteAppState? state =
        context.findAncestorStateOfType<_EasyQuoteAppState>();
    state?.changeLanguage(newLocale);
  }

  @override
  State<EasyQuoteApp> createState() => _EasyQuoteAppState();
}

class _EasyQuoteAppState extends State<EasyQuoteApp> {
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

  ///////////////BUILD///////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    bool touchMode = true;
    double densityAmt = touchMode ? 0.0 : -1.0;
    VisualDensity density =
        VisualDensity(horizontal: densityAmt, vertical: densityAmt);
    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: density,
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
      home: MainAppScaffold(restorationId: 'counter'),
    );
    // return Builder(
    //   builder: (context) {
    //     bool touchMode = context.select((ApplicationState m) => m.touchMode);
    //     double densityAmt = touchMode ? 0.0 : -1.0;
    //     VisualDensity density =
    //         VisualDensity(horizontal: densityAmt, vertical: densityAmt);
    //     return MultiProvider(
    //       providers: [
    //         ChangeNotifierProvider<ApplicationState>.value(
    //           value: _appState.value,
    //         ),
    //       ],
    //       child: MaterialApp(
    //         // theme: ThemeData(visualDensity: density),
    //         theme: ThemeData(
    //           textTheme: GoogleFonts.notoSansTextTheme(
    //             Theme.of(context).textTheme,
    //           ),
    //           visualDensity: density,
    //           pageTransitionsTheme: PageTransitionsTheme(builders: {
    //             TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    //             TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    //           }),
    //         ),
    //         debugShowCheckedModeBanner: false,
    //         localizationsDelegates: const [
    //           AppLocalizations.delegate,
    //           GlobalMaterialLocalizations.delegate,
    //           GlobalWidgetsLocalizations.delegate,
    //           GlobalCupertinoLocalizations.delegate,
    //         ],
    //         // locale: _locale,
    //         supportedLocales: const [
    //           Locale('en', ''), // English, no country code
    //           Locale.fromSubtags(
    //               languageCode: 'zh',
    //               scriptCode: 'Hant',
    //               countryCode: 'HK'), // Spanish, no country code
    //         ],
    //         home: MainAppScaffold(),
    //       ),
    //     );
    //   },
    // );
  }
}

class MainAppScaffold extends StatefulWidget {
  const MainAppScaffold({Key? key, this.restorationId}) : super(key: key);
  final String? restorationId;

  @override
  _MainAppScaffoldState createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold>
    with RestorationMixin {
  final RestorableInt _counter = RestorableInt(0);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_counter, 'count');
  }

  void _incrementCounter() {
    setState(() {
      _counter.value++;
    });
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   var appState = Provider.of<ApplicationState>(context);
  //   if (appState.loginState == ApplicationLoginState.loggedIn) {
  //     return VerifyEmailPage();
  //   } else {
  //     print("Not Login");
  //     return LoginPage();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restorable Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}