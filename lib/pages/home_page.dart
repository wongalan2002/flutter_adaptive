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
//                                     !await keyTwo.currentState!.maybePop(),
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
//                             // _SideMenu(),
//                             // Expanded(child: _PageStack()),
//                             // ],
//                             ),
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
//                   Container(width: 1, height: double.infinity, color: dimGrey)),
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
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:adaptive_app_demos/application_state.dart';
import 'package:adaptive_app_demos/fucker_MainBU.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../adaptive.dart';
import 'bottom_drawer.dart';
import 'mailbox_body.dart';

final desktopMailNavKey = GlobalKey<NavigatorState>();
final mobileMailNavKey = GlobalKey<NavigatorState>();
const double _kFlingVelocity = 2.0;
const _kAnimationDuration = Duration(milliseconds: 300);
enum MailboxPageType {
  inbox,
  starred,
  sent,
  trash,
  spam,
  drafts,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  UniqueKey _inboxKey = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isTablet = isDisplaySmallDesktop(context);
    final localizations = AppLocalizations.of(context)!;
    final _navigationDestinations = <_Destination>[
      _Destination(
        type: MailboxPageType.inbox,
        textLabel: "localizations.replyInboxLabel",
        // icon: '$_iconAssetLocation/twotone_inbox.png',
      ),
      _Destination(
        type: MailboxPageType.starred,
        textLabel: "localizations.replyStarredLabel",
        // icon: '$_iconAssetLocation/twotone_star.png',
      ),
      _Destination(
        type: MailboxPageType.sent,
        textLabel: "localizations.replySentLabel",
        // icon: '$_iconAssetLocation/twotone_send.png',
      ),
      _Destination(
        type: MailboxPageType.trash,
        textLabel: "localizations.replyTrashLabel",
        // icon: '$_iconAssetLocation/twotone_delete.png',
      ),
      _Destination(
        type: MailboxPageType.spam,
        textLabel: "localizations.replySpamLabel",
        // icon: '$_iconAssetLocation/twotone_error.png',
      ),
      _Destination(
        type: MailboxPageType.drafts,
        textLabel: "localizations.replyDraftsLabel",
        // icon: '$_iconAssetLocation/twotone_drafts.png',
      ),
    ];

    // final _folders = <String, String>{
    //   'Receipts': _folderIconAssetLocation,
    //   'Pine Elementary': _folderIconAssetLocation,
    //   'Taxes': _folderIconAssetLocation,
    //   'Vacation': _folderIconAssetLocation,
    //   'Mortgage': _folderIconAssetLocation,
    //   'Freelance': _folderIconAssetLocation,
    // };

    if (isDesktop) {
      return _DesktopNav(
        inboxKey: _inboxKey,
        extended: !isTablet,
        destinations: _navigationDestinations,
        // folders: _folders,
        onItemTapped: _onDestinationSelected,
      );
    } else {
      return _MobileNav(
        inboxKey: _inboxKey,
        destinations: _navigationDestinations,
        // folders: _folders,
        onItemTapped: _onDestinationSelected,
      );
    }
  }

  void _onDestinationSelected(int index, MailboxPageType destination) {
    var appState = Provider.of<ApplicationState>(
      context,
      listen: false,
    );

    final isDesktop = isDisplayDesktop(context);

    if (appState.selectedMenuIndex != destination) {
      _inboxKey = UniqueKey();
    }

    // appState.selectedMenuIndex = destination;
    appState.selectedMenuIndex = 0;
    if (isDesktop) {
      while (desktopMailNavKey.currentState!.canPop()) {
        desktopMailNavKey.currentState!.pop();
      }
    }

    // if (appState.onMailView) {
    //   if (!isDesktop) {
    //     mobileMailNavKey.currentState.pop();
    //   }
    //
    //   appState.selectedEmailId = -1;
    // }
  }
}

class _DesktopNav extends StatefulWidget {
  const _DesktopNav({
    Key? key,
    required this.inboxKey,
    required this.extended,
    required this.destinations,
    // required this.folders,
    required this.onItemTapped,
  }) : super(key: key);

  final bool extended;
  final UniqueKey inboxKey;
  final List<_Destination> destinations;
  // final Map<String, String> folders;
  final void Function(int, MailboxPageType) onItemTapped;

  @override
  _DesktopNavState createState() => _DesktopNavState();
}

class _DesktopNavState extends State<_DesktopNav>
    with SingleTickerProviderStateMixin {
  late ValueNotifier<bool> _isExtended;

  @override
  void initState() {
    super.initState();
    _isExtended = ValueNotifier<bool>(widget.extended);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Consumer<ApplicationState>(
            builder: (context, model, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final selectedIndex =
                      widget.destinations.indexWhere((destination) {
                    return destination.type == model.selectedMailboxPage;
                  });
                  return Container(
                    color:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _isExtended,
                            builder: (context, value, child) {
                              return NavigationRail(
                                destinations: [
                                  for (var destination in widget.destinations)
                                    NavigationRailDestination(
                                      icon: Material(
                                          key: ValueKey(
                                            'Reply-${destination.textLabel}',
                                          ),
                                          color: Colors.transparent,
                                          child: Icon(Icons.email)),
                                      label: Text(destination.textLabel),
                                    ),
                                ],
                                extended: _isExtended.value,
                                labelType: NavigationRailLabelType.none,
                                leading: _NavigationRailHeader(
                                  extended: _isExtended,
                                ),
                                // trailing: _NavigationRailFolderSection(
                                //   folders: widget.folders,
                                // ),
                                selectedIndex: selectedIndex,
                                onDestinationSelected: (index) {
                                  widget.onItemTapped(
                                    index,
                                    widget.destinations[index].type,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1340),
                child: _MailNavigator(
                  child: MailboxBody(key: widget.inboxKey),
                ),
                // child: _SharedAxisTransitionSwitcher(
                //   defaultChild: _MailNavigator(
                //     child: MailboxBody(key: widget.inboxKey),
                //   ),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MobileNav extends StatefulWidget {
  const _MobileNav({
    required this.inboxKey,
    required this.destinations,
    // required this.folders,
    required this.onItemTapped,
  });

  final UniqueKey inboxKey;
  final List<_Destination> destinations;
  // final Map<String, String> folders;
  final void Function(int, MailboxPageType) onItemTapped;

  @override
  _MobileNavState createState() => _MobileNavState();
}

class _MobileNavState extends State<_MobileNav> with TickerProviderStateMixin {
  final _bottomDrawerKey = GlobalKey(debugLabel: 'Bottom Drawer');
  late AnimationController _drawerController;
  late AnimationController _dropArrowController;
  late AnimationController _bottomAppBarController;
  late Animation<double> _drawerCurve;
  late Animation<double> _dropArrowCurve;
  late Animation<double> _bottomAppBarCurve;

  @override
  void initState() {
    super.initState();
    _drawerController = AnimationController(
      duration: _kAnimationDuration,
      value: 0,
      vsync: this,
    )..addListener(() {
        if (_drawerController.value < 0.01) {
          setState(() {
            //Reload state when drawer is at its smallest to toggle visibility
            //If state is reloaded before this drawer closes abruptly instead
            //of animating.
          });
        }
      });

    _dropArrowController = AnimationController(
      duration: _kAnimationDuration,
      vsync: this,
    );

    _bottomAppBarController = AnimationController(
      vsync: this,
      value: 1,
      duration: const Duration(milliseconds: 250),
    );

    _drawerCurve = CurvedAnimation(
      parent: _drawerController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _dropArrowCurve = CurvedAnimation(
      parent: _dropArrowController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );

    _bottomAppBarCurve = CurvedAnimation(
      parent: _bottomAppBarController,
      curve: standardEasing,
      reverseCurve: standardEasing.flipped,
    );
  }

  @override
  void dispose() {
    _drawerController.dispose();
    _dropArrowController.dispose();
    _bottomAppBarController.dispose();
    super.dispose();
  }

  bool get _bottomDrawerVisible {
    final status = _drawerController.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBottomDrawerVisibility() {
    if (_drawerController.value < 0.4) {
      _drawerController.animateTo(0.4, curve: standardEasing);
      _dropArrowController.animateTo(0.35, curve: standardEasing);
      return;
    }

    _dropArrowController.forward();
    _drawerController.fling(
      velocity: _bottomDrawerVisible ? -_kFlingVelocity : _kFlingVelocity,
    );
  }

  double get _bottomDrawerHeight {
    final renderBox =
        _bottomDrawerKey.currentContext?.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _drawerController.value -= details.primaryDelta! / _bottomDrawerHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_drawerController.isAnimating ||
        _drawerController.status == AnimationStatus.completed) {
      return;
    }

    final flingVelocity =
        details.velocity.pixelsPerSecond.dy / _bottomDrawerHeight;

    if (flingVelocity < 0.0) {
      _drawerController.fling(
        velocity: math.max(_kFlingVelocity, -flingVelocity),
      );
    } else if (flingVelocity > 0.0) {
      _dropArrowController.forward();
      _drawerController.fling(
        velocity: math.min(-_kFlingVelocity, -flingVelocity),
      );
    } else {
      if (_drawerController.value < 0.6) {
        _dropArrowController.forward();
      }
      _drawerController.fling(
        velocity:
            _drawerController.value < 0.6 ? -_kFlingVelocity : _kFlingVelocity,
      );
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        switch (notification.direction) {
          case ScrollDirection.forward:
            _bottomAppBarController.forward();
            break;
          case ScrollDirection.reverse:
            _bottomAppBarController.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final drawerSize = constraints.biggest;
    final drawerTop = drawerSize.height;

    final drawerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, drawerTop, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_drawerCurve);

    return Stack(
      clipBehavior: Clip.none,
      key: _bottomDrawerKey,
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotification,
          child: _MailNavigator(
            child: MailboxBody(
              key: widget.inboxKey,
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              _drawerController.reverse();
              _dropArrowController.reverse();
            },
            child: Visibility(
              maintainAnimation: true,
              maintainState: true,
              visible: _bottomDrawerVisible,
              child: FadeTransition(
                opacity: _drawerCurve,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color:
                      Theme.of(context).bottomSheetTheme.modalBackgroundColor,
                ),
              ),
            ),
          ),
        ),
        PositionedTransition(
          rect: drawerAnimation,
          child: Visibility(
            visible: _bottomDrawerVisible,
            // child: Text("BottomDrawer"),
            child: BottomDrawer(
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
              leading: Consumer<ApplicationState>(
                builder: (context, model, child) {
                  return _BottomDrawerDestinations(
                    destinations: widget.destinations,
                    drawerController: _drawerController,
                    dropArrowController: _dropArrowController,
                    selectedMailbox: model.selectedMailboxPage,
                    onItemTapped: widget.onItemTapped,
                  );
                },
              ),
              trailing:Text("FUCKER _BottomDrawerFolderSection"),
              // trailing: _BottomDrawerFolderSection(folders: widget.folders),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SharedAxisTransitionSwitcher(
      defaultChild: Scaffold(
        extendBody: true,
        body: LayoutBuilder(
          builder: _buildStack,
        ),
        bottomNavigationBar: Consumer<ApplicationState>(
          builder: (context, model, child) {
            return _AnimatedBottomAppBar(
              bottomAppBarController: _bottomAppBarController,
              bottomAppBarCurve: _bottomAppBarCurve,
              bottomDrawerVisible: _bottomDrawerVisible,
              drawerController: _drawerController,
              dropArrowCurve: _dropArrowCurve,
              navigationDestinations: widget.destinations,
              // selectedMailbox: model.selectedMailboxPage,
              selectedMailbox: model.selectedMailboxPage,
              toggleBottomDrawerVisibility: _toggleBottomDrawerVisibility,
            );
          },
        ),
        floatingActionButton: _bottomDrawerVisible
            ? null
            : const Padding(
                padding: EdgeInsetsDirectional.only(bottom: 8),
                child: Text("REPLY"),
          // child: _ReplyFab(),
          
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class _NavigationRailHeader extends StatelessWidget {
  const _NavigationRailHeader({
    required this.extended,
  }) : assert(extended != null);

  final ValueNotifier<bool> extended;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final animation = NavigationRail.extendedAnimation(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Align(
          alignment: AlignmentDirectional.centerStart,
          widthFactor: animation.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 56,
                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    InkWell(
                      key: const ValueKey('ReplyLogo'),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      onTap: () {
                        extended.value = !extended.value;
                      },
                      child: Row(
                        children: [
                          Transform.rotate(
                            angle: animation.value * math.pi,
                            child: const Icon(
                              Icons.arrow_left,
                              // color: ReplyColors.white50,
                              size: 16,
                            ),
                          ),
                          // const _ReplyLogo(),
                          const SizedBox(width: 10),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            widthFactor: animation.value,
                            child: Opacity(
                              opacity: animation.value,
                              child: Text(
                                'REPLY',
                                // style: textTheme.bodyText1.copyWith(
                                //   color: ReplyColors.white50,
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(width: 18 * animation.value),
                        ],
                      ),
                    ),
                    if (animation.value > 0)
                      Opacity(
                        opacity: animation.value,
                        child: Row(
                          children: const [
                            SizedBox(width: 18),
                            // ProfileAvatar(
                            //   avatar: 'reply/avatars/avatar_2.jpg',
                            //   radius: 16,
                            // ),
                            SizedBox(width: 12),
                            Icon(
                              Icons.settings,
                              // color: ReplyColors.white50,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 8,
                ),
                child: Text("FUCKERS")
                // child: _ReplyFab(extended: extended.value),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _BottomDrawerFolderSection extends StatelessWidget {
  const _BottomDrawerFolderSection({required this.folders})
      : assert(folders != null);

  final Map<String, String> folders;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigationRailTheme = theme.navigationRailTheme;

    return Column(
      children: [
        for (var folder in folders.keys)
          InkWell(
            onTap: () {},
            child: ListTile(
              mouseCursor: SystemMouseCursors.click,
              // leading: ImageIcon(
              //   AssetImage(
              //     folders[folder],
              //     package: _assetsPackage,
              //   ),
              //   color: navigationRailTheme.unselectedLabelTextStyle.color,
              // ),
              title: Text(
                folder,
                // style: theme.textTheme.bodyText2.copyWith(
                //   color: navigationRailTheme.unselectedLabelTextStyle.color,
                // ),
              ),
            ),
          ),
      ],
    );
  }
}

class _NavigationRailFolderSection extends StatelessWidget {
  const _NavigationRailFolderSection({required this.folders})
      : assert(folders != null);

  final Map<String, String> folders;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final navigationRailTheme = theme.navigationRailTheme;
    final animation = NavigationRail.extendedAnimation(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Visibility(
          maintainAnimation: true,
          maintainState: true,
          visible: animation.value > 0,
          child: Opacity(
            opacity: animation.value,
            child: Align(
              widthFactor: animation.value,
              alignment: AlignmentDirectional.centerStart,
              child: SizedBox(
                height: 485,
                width: 256,
                child: ListView(
                  padding: const EdgeInsets.all(12),
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const Divider(
                      color: Colors.red,
                      thickness: 0.4,
                      indent: 14,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 16,
                      ),
                      child: Text(
                        'FOLDERS',
                        // style: textTheme.caption.copyWith(
                        //   color: navigationRailTheme
                        //       .unselectedLabelTextStyle.color,
                        // ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (var folder in folders.keys)
                      InkWell(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(36),
                        ),
                        onTap: () {},
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 12),
                                // ImageIcon(
                                //   AssetImage(
                                //     folders[folder],
                                //     package: _assetsPackage,
                                //   ),
                                //   color: navigationRailTheme
                                //       .unselectedLabelTextStyle.color,
                                // ),
                                const SizedBox(width: 24),
                                Text(
                                  folder,
                                  // style: textTheme.bodyText1.copyWith(
                                  //   color: navigationRailTheme
                                  //       .unselectedLabelTextStyle.color,
                                  // ),
                                ),
                                const SizedBox(height: 72),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Destination {
  const _Destination({
    required this.type,
    required this.textLabel,
    // required this.icon,
  })  : assert(type != null),
        assert(textLabel != null);

  // Which mailbox page to display. For example, 'Starred' or 'Trash'.
  final MailboxPageType type;
  // The localized text label for the inbox.
  final String textLabel;
  // The icon that appears next to the text label for the inbox.
  // final String icon;
}

class _FadeThroughTransitionSwitcher extends StatelessWidget {
  const _FadeThroughTransitionSwitcher({
    required this.fillColor,
    required this.child,
  })  : assert(fillColor != null),
        assert(child != null);

  final Widget child;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeThroughTransition(
          fillColor: fillColor,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: child,
    );
  }
}

class _SharedAxisTransitionSwitcher extends StatelessWidget {
  const _SharedAxisTransitionSwitcher({
    required this.defaultChild,
  }) : assert(defaultChild != null);

  final Widget defaultChild;

  @override
  Widget build(BuildContext context) {
    // return Text("FUCK");
    return Selector<ApplicationState, bool>(
      selector: (context, emailStore) => emailStore.onSearchPage,
      builder: (context, onSearchPage, child) {
        return PageTransitionSwitcher(
          reverse: !onSearchPage,
          transitionBuilder: (child, animation, secondaryAnimation) {
            return SharedAxisTransition(
              fillColor: Theme.of(context).colorScheme.background,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
              child: child,
            );
          },
          child: onSearchPage ? const Text("I am a FUCKER SEARCH") : defaultChild,
          // child: onSearchPage ? const SearchPage() : defaultChild,
        );
      },
    );
  }
}
class _AnimatedBottomAppBar extends StatelessWidget {
  const _AnimatedBottomAppBar({
    required this.bottomAppBarController,
    required this.bottomAppBarCurve,
    required this.bottomDrawerVisible,
    required this.drawerController,
    required this.dropArrowCurve,
    required this.navigationDestinations,
    required this.selectedMailbox,
    required this.toggleBottomDrawerVisibility,
  });

  final AnimationController bottomAppBarController;
  final Animation<double> bottomAppBarCurve;
  final bool bottomDrawerVisible;
  final AnimationController drawerController;
  final Animation<double> dropArrowCurve;
  final List<_Destination> navigationDestinations;
  final MailboxPageType selectedMailbox;
  final ui.VoidCallback toggleBottomDrawerVisibility;

  @override
  Widget build(BuildContext context) {
    var fadeOut = Tween<double>(begin: 1, end: -1).animate(
      drawerController.drive(CurveTween(curve: standardEasing)),
    );

    return Selector<ApplicationState, bool>(
      selector: (context, emailStore) => true,
      // selector: (context, emailStore) => emailStore.onMailView,
      builder: (context, onMailView, child) {
        bottomAppBarController.forward();

        return SizeTransition(
          sizeFactor: bottomAppBarCurve,
          axisAlignment: -1,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(top: 2),
            child: BottomAppBar(
              // shape: const WaterfallNotchedRectangle(),
              notchMargin: 6,
              child: Container(
                color: Colors.transparent,
                height: kToolbarHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      key: const ValueKey('navigation_button'),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      onTap: toggleBottomDrawerVisibility,
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          RotationTransition(
                            turns: Tween(
                              begin: 0.0,
                              end: 1.0,
                            ).animate(dropArrowCurve),
                            child: const Icon(
                              Icons.arrow_drop_up,
                              // color: ReplyColors.white50,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // const _ReplyLogo(),
                          const SizedBox(width: 10),
                          _FadeThroughTransitionSwitcher(
                            fillColor: Colors.transparent,
                            child: onMailView
                                ? const SizedBox(width: 48)
                                : FadeTransition(
                              opacity: fadeOut,
                              child: Text(
                                navigationDestinations
                                    .firstWhere((destination) {
                                  return destination.type ==
                                      selectedMailbox;
                                }).textLabel,
                                // style: Theme.of(context)
                                //     .textTheme
                                //     .bodyText1
                                //     .copyWith(color: ReplyColors.white50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Text("_BottomAppBarActionItems")
                        // child: _BottomAppBarActionItems(
                        //   drawerVisible: bottomDrawerVisible,
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


class _BottomDrawerDestinations extends StatelessWidget {
  const _BottomDrawerDestinations({
    required this.destinations,
    required this.drawerController,
    required this.dropArrowController,
    required this.selectedMailbox,
    required this.onItemTapped,
  })  : assert(destinations != null),
        assert(drawerController != null),
        assert(dropArrowController != null),
        assert(selectedMailbox != null),
        assert(onItemTapped != null);

  final List<_Destination> destinations;
  final AnimationController drawerController;
  final AnimationController dropArrowController;
  final MailboxPageType selectedMailbox;
  final void Function(int, MailboxPageType) onItemTapped;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final destinationButtons = <Widget>[];

    for (var index = 0; index < destinations.length; index += 1) {
      var destination = destinations[index];
      destinationButtons.add(
        InkWell(
          key: ValueKey('Reply-${destination.textLabel}'),
          onTap: () {
            drawerController.reverse();
            dropArrowController.forward();
            Future.delayed(
              Duration(
                milliseconds: 300,
              ),
              () {
                // Wait until animations are complete to reload the state.
                // Delay scales with the timeDilation value of the gallery.
                onItemTapped(index, destination.type);
              },
            );
          },
          child: ListTile(
              mouseCursor: SystemMouseCursors.click,
              leading: Icon(Icons.reply),
              iconColor: destination.type == selectedMailbox
                  ? Colors.red
                  : Colors.blue,
              title: Text(destination.textLabel)),

          // style: theme.textTheme.bodyText2.copyWith(
          //   color: destination.type == selectedMailbox
          //       ? theme.colorScheme.secondary
          //       : theme.navigationRailTheme.unselectedLabelTextStyle.color,
          // ),
          // ),
        ),
      );
    }

    return Column(
      children: destinationButtons,
    );
  }
}

class _MailNavigator extends StatefulWidget {
  const _MailNavigator({required this.child}) : assert(child != null);

  final Widget child;

  @override
  _MailNavigatorState createState() => _MailNavigatorState();
}

class _MailNavigatorState extends State<_MailNavigator> {
  static const inboxRoute = '/reply/inbox';

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return Navigator(
      restorationScopeId: 'replyMailNavigator',
      key: isDesktop ? desktopMailNavKey : mobileMailNavKey,
      initialRoute: inboxRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case inboxRoute:
            return MaterialPageRoute<void>(
              builder: (context) {
                return _FadeThroughTransitionSwitcher(
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  child: widget.child,
                );
              },
              settings: settings,
            );
            break;
          // case EasyQuoteApp.composeRoute:
          //   return EasyQuoteApp.createComposeRoute(settings);
          //   break;
        }
        return null;
      },
    );
  }
}
