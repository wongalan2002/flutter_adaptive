import 'package:adaptive_app_demos/pages/quotation_edit_page.dart';
import 'package:adaptive_app_demos/pages/quotation_order_list_page.dart';
import 'package:adaptive_app_demos/pages/setting_page.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../global/device_size.dart';
import '../global/styling.dart';
import '../global/targeted_actions.dart';
import '../widgets/app_title_bar.dart';
import '../widgets/buttons.dart';
import '../widgets/ok_cancel_dialog.dart';
import 'adaptive_data_table_page.dart';
import 'adaptive_grid_page.dart';
import 'adaptive_reflow_page.dart';
import 'quotations_list_page.dart';
import 'start_page.dart';
import 'focus_examples_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var keyOne = GlobalKey<NavigatorState>();
  var keyTwo = GlobalKey<NavigatorState>();

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
                child: Focus(
                  autofocus: true,
                  child: Scaffold(
                    key: _scaffoldKey,
                    // drawer: useTabs ? _SideMenu(showPageButtons: false) : null,
                    // appBar: useTabs
                    //     ? AppBar(backgroundColor: Colors.blue.shade300)
                    //     : null,
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
                        Row(children: [
                          _SideMenu(),
                          Expanded(
                            child: Container(
                              child: WillPopScope(
                                onWillPop: () async =>
                                    !await keyTwo.currentState!.maybePop(),
                                child: Navigator(
                                  key: keyTwo,
                                  onGenerateRoute: (routeSettings) {
                                    return MaterialPageRoute(
                                      builder: (context) => _PageStack(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]
                            // _SideMenu(),
                            // Expanded(child: _PageStack()),
                            // ],
                            ),
                      ],
                    ]),
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
    int index = context.select((ApplicationState model) => model.selectedMenuIndex);
    Widget? page;
    // if (index == 0) page = AdaptiveGridPage();
    if (index == 0) page = StartPage();
    // if (index == 1) page = AdaptiveDataTablePage();
    if (index == 1) page = QuotationsListPage();
    if (index == 2) page = SettingPage();
    // if (index == 2) page = AdaptiveReflowPage();
    // if (index == 3) page = FocusExamplesPage();
    if (index == 3) page = QuotationOrderListPage();
    if (index == 4) page = QuotationEditPage(isEdit: false,  restorationId: 'quotationEdit');
    return FocusTraversalGroup(child: page ?? Container());
  }
}

class _SideMenu extends StatelessWidget {
  const _SideMenu({Key? key, this.showPageButtons = true}) : super(key: key);
  final bool showPageButtons;

  @override
  Widget build(BuildContext context) {
    // void _handleLogoutPressed() async {
    //   String message = "Are you sure you want to logout?";
    //   bool? doLogout = await showDialog(
    //       context: context, builder: (_) => OkCancelDialog(message: message));
    //   if (doLogout ?? false) {
    //     context.read<ApplicationState>().signOut();
    //     // context.read<AppModel>().logout();
    //   }
    // }
    return Container(
      color: backgroundColor,
      width: 250,
      child: Stack(
        children: [
          // Buttons
          Column(children: [
            SizedBox(height: Insets.extraLarge),
            if (showPageButtons) ...getMainMenuChildren(context),
            // SizedBox(height: Insets.extraLarge),
            // SecondaryMenuButton(label: "Submenu Item 1"),
            // SecondaryMenuButton(label: "Submenu Item 2"),
            // SecondaryMenuButton(label: "Submenu Item 3"),
            Spacer(),
            // OutlinedButton(
            //     child: Text("Logout"), onPressed: _handleLogoutPressed),
            // SizedBox(height: Insets.large),
          ]),
          // Divider
          Align(
              alignment: Alignment.centerRight,
              child:
                  Container(width: 1, height: double.infinity, color: dimGrey)),
        ],
      ),
    );
  }
}

List<Widget> getMainMenuChildren(BuildContext context) {
  // Define a method to change pages in the AppModel
  void changePage(int value) =>
      context.read<ApplicationState>().selectedMenuIndex = value;
  int index = context.select((ApplicationState m) => m.selectedMenuIndex);
  return [
    SelectedPageButton(
      onPressed: () => changePage(0),
      label: "Home",
      isSelected: index == 0,
      iconPath: "assets/icons/Home.svg",
    ),
    SelectedPageButton(
      onPressed: () => changePage(1),
      label: "Quotation",
      isSelected: index == 1,
      iconPath: "assets/icons/List.svg",
    ),
    SelectedPageButton(
      onPressed: () => changePage(2),
      label: "Setting",
      isSelected: index == 2,
      iconPath: "assets/icons/Setting.svg",
    ),
    // SelectedPageButton(
    //     onPressed: () => changePage(3),
    //     label: "Focus Examples",
    //     isSelected: index == 3),
  ];
}

class _TabMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap all the main menu buttons in Expanded() so they fill up the screen horizontally
    List<Expanded> tabButtons = getMainMenuChildren(context)
        .map((btn) => Expanded(child: btn))
        .toList();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 10,
            blurRadius: 10,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Divider
          // Container(width: double.infinity, height: 1, color: Colors.blue),
          // Tab buttons
          Row(children: tabButtons),
        ],
      ),
    );
  }
}
