import 'package:adaptive_app_demos/app_model.dart';
import 'package:adaptive_app_demos/main_app_scaffold.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
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
      builder: (context, _) => AppScaffold(),
    ),

    // AppScaffold()
  );

  // Required when using bits_dojo for custom TitleBars
  doWhenWindowReady(() {
    appWindow.title = "Adaptive App Demo";
    appWindow.show();
  });
}

class AppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        bool touchMode = context.select((ApplicationState m) => m.touchMode);
        double densityAmt = touchMode ? 0.0 : -1.0;
        VisualDensity density =
            VisualDensity(horizontal: densityAmt, vertical: densityAmt);
        return MaterialApp(
          theme: ThemeData(visualDensity: density),
          home: MainAppScaffold(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
