// import 'package:adaptive_app_demos/models/quotation_order.dart';
// import 'package:adaptive_app_demos/pages/quotation_edit_page.dart';
// import 'package:adaptive_app_demos/pages/setting_page.dart';
//
// import 'package:bitsdojo_window/bitsdojo_window.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
//
// import '../application_state.dart';
// import '../global/device_size.dart';
// import '../global/styling.dart';
// import '../global/targeted_actions.dart';
// import '../widgets/buttons.dart';
// import 'adaptive_grid_page.dart';
// import 'quotations_list_page.dart';
// import 'start_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//   @override
//   HomePageState createState() => HomePageState();
// }
//
// class HomePageState extends State<HomePage> with RestorationMixin {
//   // final _RestorableAppState _appState = _RestorableAppState();
//   late RestorableInt _fucker = RestorableInt(0);
//
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   var keyOne = GlobalKey<NavigatorState>();
//   var keyTwo = GlobalKey<NavigatorState>();
//
//   @override
//   String get restorationId => 'myState';
//
//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_fucker, 'state');
//   }
//
//   @override
//   void dispose() {
//     _fucker.dispose();
//     super.dispose();
//   }
//
//
//   void jumpToMenu(index) {
//     print("asshole: ${index}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool useTabs = MediaQuery.of(context).size.width < FormFactor.tablet;
//
//     return TargetedActionScope(
//       shortcuts: <LogicalKeySet, Intent>{
//         LogicalKeySet(LogicalKeyboardKey.keyA, LogicalKeyboardKey.control):
//         SelectAllIntent(),
//         LogicalKeySet(LogicalKeyboardKey.keyS, LogicalKeyboardKey.control):
//         SelectNoneIntent(),
//         LogicalKeySet(LogicalKeyboardKey.delete): DeleteIntent(),
//       },
//       child: WindowBorder(
//         color: Colors.white,
//         child: Material(
//           child: Column(
//             children: [
//               // AppTitleBar(),
//               Expanded(
//                 child: Focus(
//                   autofocus: true,
//                   child: Scaffold(
//                     key: _scaffoldKey,
//                     // drawer: useTabs ? _SideMenu(showPageButtons: false) : null,
//                     // appBar: useTabs
//                     //     ? AppBar(backgroundColor: Colors.blue.shade300)
//                     //     : null,
//                     body: Stack(children: [
//                       // Vertical layout with Tab controller and drawer
//                       if (useTabs) ...[
//                         Column(
//                           children: [
//                             Expanded(child: _PageStack()),
//                             TabMenu(),
//                           ],
//                         )
//                       ]
//                       // Horizontal layout with desktop style side menu
//                       else ...[
//                         Row(children: [
//                           _SideMenu(),
//                           Expanded(
//                             child: Container(
//                               child: WillPopScope(
//                                 onWillPop: () async =>
//                                 !await keyTwo.currentState!.maybePop(),
//                                 child: Navigator(
//                                   key: keyTwo,
//                                   onGenerateRoute: (routeSettings) {
//                                     return MaterialPageRoute(
//                                       builder: (context) =>
//                                           _PageStack(),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]
//                           // _SideMenu(),
//                           // Expanded(child: _PageStack()),
//                           // ],
//                         ),
//                       ],
//                     ]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // class _RestorableAppState extends RestorableListenable<ApplicationState> {
// //   @override
// //   ApplicationState createDefaultValue() {
// //     return ApplicationState();
// //   }
// //
// //   @override
// //   ApplicationState fromPrimitives(Object? data) {
// //     final appState = ApplicationState();
// //     final appData = Map<String, dynamic>.from(data as Map);
// //     appState.selectedMenuIndex = appData['selectedMenuIndex'] as int;
// //     // appState.quotationOrder = appData['quotationOrder'] as QuotationOrder;
// //     print("From appState.selectedMenuIndex: ${appState.selectedMenuIndex}");
// //     return appState;
// //   }
// //
// //   @override
// //   Object? toPrimitives() {
// //     print("TO value: ${value.userProfile.schoolName}");
// //     // print("TO quotationOrder: ${value.quotationOrder}");
// //     print("TO value.selectedMenuIndex: ${value.selectedMenuIndex}");
// //     return <String, dynamic>{
// //       'selectedMenuIndex': value.selectedMenuIndex,
// //       // 'quotationOrder': value.quotationOrder,
// //       // 'selectedEmailId': value.selectedEmailId,
// //       // // The index of the MailboxPageType enum is stored, since the value
// //       // // has to be serializable.
// //       // 'selectedMailboxPage': value.selectedMailboxPage.index,
// //       // 'onSearchPage': value.onSearchPage,
// //       // 'starredEmailIds': value.starredEmailIds.toList(),
// //       // 'trashEmailIds': value.trashEmailIds.toList(),
// //     };
// //   }
// // }
//
// class _PageStack extends StatefulWidget {
//   // _PageStack({required this.callback});
//   // late Function callback;
//
//   @override
//   State<_PageStack> createState() => _PageStackState();
// }
//
// class _PageStackState extends State<_PageStack> {
//   @override
//   Widget build(BuildContext context) {
//     int index = context.select((ApplicationState model) => model.selectedMenuIndex);
//     Widget? page;
//     // if (index == 0) page = AdaptiveGridPage();
//     if (index == 0) page = StartPage();
//     // if (index == 1) page = AdaptiveDataTablePage();
//     if (index == 1) page = QuotationsListPage();
//     if (index == 2) page = SettingPage();
//     // if (index == 2) page = AdaptiveReflowPage();
//     // if (index == 3) page = FocusExamplesPage();
//     // if (index == 3) page = QuotationOrderListPage();
//     if (index == 4) page = QuotationEditPage(isEdit: false);
//     return FocusTraversalGroup(child: page ?? Container());
//   }
// }
//
// class _SideMenu extends StatelessWidget {
//   const _SideMenu({Key? key, this.showPageButtons = true}) : super(key: key);
//   final bool showPageButtons;
//
//   @override
//   Widget build(BuildContext context) {
//     // void _handleLogoutPressed() async {
//     //   String message = "Are you sure you want to logout?";
//     //   bool? doLogout = await showDialog(
//     //       context: context, builder: (_) => OkCancelDialog(message: message));
//     //   if (doLogout ?? false) {
//     //     context.read<ApplicationState>().signOut();
//     //     // context.read<AppModel>().logout();
//     //   }
//     // }
//     return Container(
//       color: backgroundColor,
//       width: 250,
//       child: Stack(
//         children: [
//           // Buttons
//           Column(children: [
//             SizedBox(height: Insets.extraLarge),
//             if (showPageButtons) ...getMainMenuChildren(context),
//             // SizedBox(height: Insets.extraLarge),
//             // SecondaryMenuButton(label: "Submenu Item 1"),
//             // SecondaryMenuButton(label: "Submenu Item 2"),
//             // SecondaryMenuButton(label: "Submenu Item 3"),
//             Spacer(),
//             // OutlinedButton(
//             //     child: Text("Logout"), onPressed: _handleLogoutPressed),
//             // SizedBox(height: Insets.large),
//           ]),
//           // Divider
//           Align(
//               alignment: Alignment.centerRight,
//               child:
//               Container(width: 1, height: double.infinity, color: dimGrey)),
//         ],
//       ),
//     );
//   }
// }
//
// List<Widget> getMainMenuChildren(BuildContext context) {
//   final appState = Provider.of<ApplicationState>(context);
//   void changePage(int value) {
//     appState.selectedMenuIndex = value;
//   }
//
//   int index = appState.selectedMenuIndex;
//   return [
//     SelectedPageButton(
//       onPressed: () => changePage(0),
//       label: "Home",
//       isSelected: index == 0,
//       iconPath: "assets/icons/Home.svg",
//     ),
//     SelectedPageButton(
//       onPressed: () => changePage(1),
//       label: "Quotation",
//       isSelected: index == 1,
//       iconPath: "assets/icons/List.svg",
//     ),
//     SelectedPageButton(
//       onPressed: () => changePage(2),
//       label: "Setting",
//       isSelected: index == 2,
//       iconPath: "assets/icons/Setting.svg",
//     ),
//   ];
// }
//
// class TabMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Wrap all the main menu buttons in Expanded() so they fill up the screen horizontally
//     List<Expanded> tabButtons = getMainMenuChildren(context)
//         .map((btn) => Expanded(child: btn))
//         .toList();
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 10,
//             blurRadius: 10,
//             offset: Offset(0, 0), // changes position of shadow
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Top Divider
//           // Container(width: double.infinity, height: 1, color: Colors.blue),
//           // Tab buttons
//           Row(children: tabButtons),
//         ],
//       ),
//     );
//   }
// }
