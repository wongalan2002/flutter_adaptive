import 'package:adaptive_app_demos/pages/main_app_scaffold.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'application_state.dart';
import 'firebase_options.dart';

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

  // // Required when using bits_dojo for custom TitleBars
  // doWhenWindowReady(() {
  //   appWindow.title = "Easy Quote";
  //   appWindow.show();
  // });
}

class EasyQuoteApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) async {
    _EasyQuoteAppState? state = context.findAncestorStateOfType<_EasyQuoteAppState>();
    state?.changeLanguage(newLocale);
  }
  @override
  State<EasyQuoteApp> createState() => _EasyQuoteAppState();
}

class _EasyQuoteAppState extends State<EasyQuoteApp>{

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
    return Builder(
      builder: (context) {
        bool touchMode = context.select((ApplicationState m) => m.touchMode);
        double densityAmt = touchMode ? 0.0 : -1.0;
        VisualDensity density =
            VisualDensity(horizontal: densityAmt, vertical: densityAmt);
        return MaterialApp(
          // theme: ThemeData(visualDensity: density),
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
          home: MainAppScaffold(),
        );
      },
    );
  }
}
