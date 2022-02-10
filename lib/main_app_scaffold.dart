import 'dart:async';

import 'package:adaptive_app_demos/global/device_size.dart';
import 'package:adaptive_app_demos/global/styling.dart';
import 'package:adaptive_app_demos/pages/adaptive_data_table_page.dart';
import 'package:adaptive_app_demos/pages/adaptive_grid_page.dart';
import 'package:adaptive_app_demos/pages/adaptive_reflow_page.dart';
import 'package:adaptive_app_demos/pages/focus_examples_page.dart';
import 'package:adaptive_app_demos/pages/login_page.dart';
import 'package:adaptive_app_demos/widgets/buttons.dart';
import 'package:adaptive_app_demos/widgets/ok_cancel_dialog.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'application_state.dart';
import 'authentication.dart';
import 'widgets/app_title_bar.dart';
import 'global/targeted_actions.dart';

List<Widget> getMainMenuChildren(BuildContext context) {
  // Define a method to change pages in the AppModel
  void changePage(int value) =>
      context.read<ApplicationState>().selectedIndex = value;
  int index = context.select((ApplicationState m) => m.selectedIndex);
  return [
    SelectedPageButton(
        onPressed: () => changePage(0),
        label: "Adaptive Grid",
        isSelected: index == 0),
    SelectedPageButton(
        onPressed: () => changePage(1),
        label: "Adaptive Data Table",
        isSelected: index == 1),
    SelectedPageButton(
        onPressed: () => changePage(2),
        label: "Adaptive Reflow",
        isSelected: index == 2),
    SelectedPageButton(
        onPressed: () => changePage(3),
        label: "Focus Examples",
        isSelected: index == 3),
  ];
}

class MainAppScaffold extends StatefulWidget {
  @override
  _MainAppScaffoldState createState() => _MainAppScaffoldState();
}

class _MainAppScaffoldState extends State<MainAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                return _VerifyEmailPage();
              } else {
                print("未得呀");
                return LoginPage();
              }
            }));
  }
}

// class _MainAppScaffoldState extends State<MainAppScaffold> {
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     var appState = Provider.of<ApplicationState>(context);
//     bool useTabs = MediaQuery.of(context).size.width < FormFactor.tablet;
//
//     return TargetedActionScope(
//       shortcuts: <LogicalKeySet, Intent>{
//         LogicalKeySet(LogicalKeyboardKey.keyA, LogicalKeyboardKey.control):
//             SelectAllIntent(),
//         LogicalKeySet(LogicalKeyboardKey.keyS, LogicalKeyboardKey.control):
//             SelectNoneIntent(),
//         LogicalKeySet(LogicalKeyboardKey.delete): DeleteIntent(),
//       },
//       child: WindowBorder(
//         color: Colors.white,
//         child: Material(
//           child: Column(
//             children: [
//               // AppTitleBar(),
//               Expanded(
//                 child: appState.loginState == ApplicationLoginState.verifyEmail
//                     //     ? Focus(
//                     //   autofocus: true,
//                     //   child: Scaffold(
//                     //     key: _scaffoldKey,
//                     //     drawer: useTabs ? _SideMenu(showPageButtons: false) : null,
//                     //     appBar: useTabs ? AppBar(backgroundColor: Colors.blue.shade300) : null,
//                     //     body: Stack(children: [
//                     //       // Vertical layout with Tab controller and drawer
//                     //       if (useTabs) ...[
//                     //         Column(
//                     //           children: [
//                     //             Expanded(child: _PageStack()),
//                     //             _TabMenu(),
//                     //           ],
//                     //         )
//                     //       ]
//                     //       // Horizontal layout with desktop style side menu
//                     //       else ...[
//                     //         Row(
//                     //           children: [
//                     //             _SideMenu(),
//                     //             Expanded(child: _PageStack()),
//                     //           ],
//                     //         ),
//                     //       ],
//                     //     ]),
//                     //   ),
//                     // )
//                     ? _VerifyEmailPage()
//                     // Otherwise, show the full application with dynamic scaffold
//                     : LoginPage(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _VerifyEmailPage extends StatefulWidget {
  const _VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<_VerifyEmailPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
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
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
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
    bool useTabs = MediaQuery.of(context).size.width < FormFactor.tablet;

    return TargetedActionScope(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.keyA, LogicalKeyboardKey.control):
            SelectAllIntent(),
        LogicalKeySet(LogicalKeyboardKey.keyS, LogicalKeyboardKey.control):
            SelectNoneIntent(),
        LogicalKeySet(LogicalKeyboardKey.delete): DeleteIntent(),
      },
      child: WindowBorder(
        color: Colors.white,
        child: Material(
          child: Column(
            children: [
              // AppTitleBar(),
              Expanded(
                child: isEmailVerified
                    ? Focus(
                        autofocus: true,
                        child: Scaffold(
                          key: _scaffoldKey,
                          drawer: useTabs
                              ? _SideMenu(showPageButtons: false)
                              : null,
                          appBar: useTabs
                              ? AppBar(backgroundColor: Colors.blue.shade300)
                              : null,
                          body: Stack(children: [
                            // Vertical layout with Tab controller and drawer
                            if (useTabs) ...[
                              Column(
                                children: [
                                  Expanded(child: _PageStack()),
                                  _TabMenu(),
                                ],
                              )
                            ]
                            // Horizontal layout with desktop style side menu
                            else ...[
                              Row(
                                children: [
                                  _SideMenu(),
                                  Expanded(child: _PageStack()),
                                ],
                              ),
                            ],
                          ]),
                        ),
                      )
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
        ),
      ),
    );
  }
}

class _PageStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = context.select((ApplicationState model) => model.selectedIndex);
    Widget? page;
    if (index == 0) page = AdaptiveGridPage();
    if (index == 1) page = AdaptiveDataTablePage();
    if (index == 2) page = AdaptiveReflowPage();
    if (index == 3) page = FocusExamplesPage();
    return FocusTraversalGroup(child: page ?? Container());
  }
}

class _SideMenu extends StatelessWidget {
  const _SideMenu({Key? key, this.showPageButtons = true}) : super(key: key);

  final bool showPageButtons;

  @override
  Widget build(BuildContext context) {
    void _handleLogoutPressed() async {
      String message = "Are you sure you want to logout?";
      bool? doLogout = await showDialog(
          context: context, builder: (_) => OkCancelDialog(message: message));
      if (doLogout ?? false) {
        context.read<ApplicationState>().signOut();
        // context.read<AppModel>().logout();
      }
    }

    return Container(
      color: Colors.white,
      width: 250,
      child: Stack(
        children: [
          // Buttons
          Column(children: [
            SizedBox(height: Insets.extraLarge),
            if (showPageButtons) ...getMainMenuChildren(context),
            SizedBox(height: Insets.extraLarge),
            SecondaryMenuButton(label: "Submenu Item 1"),
            SecondaryMenuButton(label: "Submenu Item 2"),
            SecondaryMenuButton(label: "Submenu Item 3"),
            Spacer(),
            OutlinedButton(
                child: Text("Logout"), onPressed: _handleLogoutPressed),
            SizedBox(height: Insets.large),
          ]),
          // Divider
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                  width: 1, height: double.infinity, color: Colors.blue)),
        ],
      ),
    );
  }
}

class _TabMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap all the main menu buttons in Expanded() so they fill up the screen horizontally
    List<Expanded> tabButtons = getMainMenuChildren(context)
        .map((btn) => Expanded(child: btn))
        .toList();
    return Column(
      children: [
        // Top Divider
        Container(width: double.infinity, height: 1, color: Colors.blue),
        // Tab buttons
        Row(children: tabButtons),
      ],
    );
  }
}
