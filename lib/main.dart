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
import 'application_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => App(),
    ),
  );

  // Required when using bits_dojo for custom TitleBars
  doWhenWindowReady(() {
    appWindow.title = "Easy Quote";
    appWindow.show();
  });
}

class App extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) async {
    _AppState? state = context.findAncestorStateOfType<_AppState>();
    state?.changeLanguage(newLocale);
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(App());
// }
//
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: "/",
//       routes: {
//         '/': (context) => SomeOneView(),
//         '/two': (context) => SomeTwoView(),
//       },
//     );
//   }
// }
//
// class SomeOneView extends StatefulWidget {
//   @override
//   _SomeOneViewState createState() => _SomeOneViewState();
// }
//
// class _SomeOneViewState extends State<SomeOneView> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 100,
//           color: Colors.green,
//         ),
//         Expanded(
//           child: Container(
//             width: double.infinity,
//             color: Colors.indigo,
//             height: double.infinity,
//             margin: EdgeInsets.symmetric(horizontal: 30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 MaterialButton(
//                   color: Colors.white,
//                   child: Text('Next'),
//                   onPressed: () => Navigator.of(context).pushNamed('/two'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class SomeTwoView extends StatefulWidget {
//   @override
//   _SomeTwoViewState createState() => _SomeTwoViewState();
// }
//
// class _SomeTwoViewState extends State<SomeTwoView> {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Navigator(
//         initialRoute: "two/home",
//         onGenerateRoute: (RouteSettings settings) {
//           WidgetBuilder builder;
//           switch (settings.name) {
//             case "two/home":
//               builder = (BuildContext context) => HomeOfTwo();
//               break;
//             case "two/nextpage":
//               builder = (BuildContext context) => PageTwoOfTwo();
//               break;
//           }
//           return MaterialPageRoute(
//               builder: (x) => SomeOneView(), settings: settings);
//         },
//       ),
//     );
//   }
// }
//
// class HomeOfTwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: Colors.grey,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           ElevatedButton(
//             child: Text('Next'),
//             onPressed: () => Navigator.of(context).pushNamed('two/home'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PageTwoOfTwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       color: Colors.teal,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           MaterialButton(
//             child: Text('Next'),
//             onPressed: () => Navigator.of(context).pushNamed('/three'),
//           ),
//         ],
//       ),
//     );
//   }
// }
