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
//
// import 'package:flutter/material.dart';
//
// void main() => runApp(const RestorationExampleApp());
//
// class RestorationExampleApp extends StatelessWidget {
//   const RestorationExampleApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       restorationScopeId: 'app',
//       title: 'Restorable Counter',
//       home: RestorableCounter(restorationId: 'counter'),
//     );
//   }
// }
//
// class RestorableCounter extends StatefulWidget {
//   const RestorableCounter({Key? key, this.restorationId}) : super(key: key);
//
//   final String? restorationId;
//
//   @override
//   State<RestorableCounter> createState() => _RestorableCounterState();
// }
//
// // The [State] object uses the [RestorationMixin] to make the current value
// // of the counter restorable.
// class _RestorableCounterState extends State<RestorableCounter>
//     with RestorationMixin {
//   // The current value of the counter is stored in a [RestorableProperty].
//   // During state restoration it is automatically restored to its old value.
//   // If no restoration data is available to restore the counter from, it is
//   // initialized to the specified default value of zero.
//   final RestorableInt _counter = RestorableInt(0);
//
//   // In this example, the restoration ID for the mixin is passed in through
//   // the [StatefulWidget]'s constructor.
//   @override
//   String? get restorationId => widget.restorationId;
//
//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     // All restorable properties must be registered with the mixin. After
//     // registration, the counter either has its old value restored or is
//     // initialized to its default value.
//     registerForRestoration(_counter, 'count');
//   }
//
//   void _incrementCounter() {
//     setState(() {
//       // The current value of the property can be accessed and modified via
//       // the value getter and setter.
//       _counter.value++;
//     });
//   }
//
//   @override
//   void dispose() {
//     _counter.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Restorable Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '${_counter.value}',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }