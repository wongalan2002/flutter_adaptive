import 'package:adaptive_app_demos/pages/quotation_order_list_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../application_state.dart';
import '../global/styling.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchTextController = TextEditingController();
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.appName,
            style: EasyQuoteTextStyles.h5.copyWith(color: titleColor),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                  child: GestureDetector(
                    child: SvgPicture.asset(
                      "assets/icons/add.svg",
                    ),
                  )),
              onTap: () {
                // Navigator.of(context).push(_createRoute(QuotationOrderListPage()));
                // context.read<ApplicationState>().selectedMenuIndex = 3;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QuotationOrderListPage()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(
                //   width: double.infinity,
                //   height: 72,
                //   child: Padding(
                //     padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                //     child: ListView(
                //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         ElevatedButton(
                //           child: Text(
                //             AppLocalizations.of(context)!.hotQuotation,
                //             style:
                //                 const TextStyle(fontSize: 16, color: textColor),
                //           ),
                //           onPressed: () {},
                //           style: ElevatedButton.styleFrom(
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(30.0),
                //             ),
                //             primary: mainSessionButton,
                //             elevation: 0,
                //             shadowColor: Colors.transparent,
                //           ),
                //         ),
                //         ElevatedButton(
                //           child: Text(
                //             AppLocalizations.of(context)!.customizedQuotation,
                //             style:
                //                 const TextStyle(fontSize: 16, color: textColor),
                //           ),
                //           onPressed: () {
                //             // Navigator.push(
                //             //   context,
                //             //   MaterialPageRoute(
                //             //       builder: (context) =>
                //             //       const QuotationOrderListView()),
                //             // );
                //           },
                //           style: ElevatedButton.styleFrom(
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(30.0),
                //             ),
                //             primary: Colors.transparent,
                //             elevation: 0,
                //             shadowColor: Colors.transparent,
                //           ),
                //         ),
                //         ElevatedButton(
                //           child: Text(
                //             AppLocalizations.of(context)!.pastQuotation,
                //             style:
                //                 const TextStyle(fontSize: 16, color: textColor),
                //           ),
                //           onPressed: () {
                //             // Navigator.push(
                //             //   context,
                //             //   MaterialPageRoute(
                //             //       builder: (context) =>
                //             //       const QuotationListView()),
                //             // );
                //           },
                //           style: ElevatedButton.styleFrom(
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(30.0),
                //             ),
                //             primary: Colors.transparent,
                //             elevation: 0,
                //             shadowColor: Colors.transparent,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 10),
                // Container(
                //   width: double.infinity,
                //   height: 50,
                //   decoration: const BoxDecoration(),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     children: [
                //       Expanded(
                //         child: TextFormField(
                //           controller: _searchTextController,
                //           decoration: InputDecoration(
                //             filled: true,
                //             fillColor: Colors.white,
                //             prefixIcon: const Icon(
                //               Icons.search,
                //               color: textColor,
                //             ),
                //             contentPadding: const EdgeInsets.all(8.0),
                //             focusedBorder: OutlineInputBorder(
                //               borderSide: const BorderSide(color: Colors.white),
                //               borderRadius: BorderRadius.circular(8.0),
                //             ),
                //             enabledBorder: UnderlineInputBorder(
                //               borderSide: const BorderSide(color: Colors.white),
                //               borderRadius: BorderRadius.circular(8.0),
                //             ),
                //           ),
                //         ),
                //       ),
                //       IconButton(
                //         icon: const FaIcon(
                //           FontAwesomeIcons.slidersH,
                //           color: textColor,
                //           size: 30,
                //         ),
                //         onPressed: () {},
                //       ),
                //     ],
                //   ),
                // ),
                // const CategoryList(),
                // CategoryList(),
              ]),
        ));
  }
}


// Route _createRoute(fucker) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) =>  fucker,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.ease;
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

