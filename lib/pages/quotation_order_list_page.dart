import 'package:provider/provider.dart';

import '../application_state.dart';
import '../global/device_size.dart';
import 'quotation_order_comfirm_page.dart';
import 'quotation_edit_page.dart';
import 'quotation_item_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/quotation_order.dart';
import '../global/styling.dart';

class QuotationOrderListPage extends StatefulWidget {
  const QuotationOrderListPage({Key? key}) : super(key: key);

  @override
  _QuotationOrderListPageState createState() => _QuotationOrderListPageState();
}

class _QuotationOrderListPageState extends State<QuotationOrderListPage> {
  final _formKey = GlobalKey<FormState>();
  // late QuotationOrder _quotationOrder;
  late TextEditingController quotationRequesterTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // void didChangeDependencies() {
  //   final appState = Provider.of<ApplicationState>(context);
  //   appState.quotationOrder.quotationRequester != null
  //       ? quotationRequesterTextController.text = appState.quotationOrder.quotationRequester!
  //       : quotationRequesterTextController.text = '';
  // }

  // addQuotationItem(newValue) {
  //   setState(() {
  //     _quotationOrder.quotationItems!.add(newValue);
  //   });
  // }
  //
  // updateQuotationItem(int index, QuotationItem newValue, bool deleteThis) {
  //   if (deleteThis == true) {
  //     setState(() {
  //       _quotationOrder.quotationItems!.removeAt(index);
  //     });
  //   } else {
  //     setState(() {
  //       _quotationOrder.quotationItems![index] = newValue;
  //     });
  //   }
  // }
  //
  // deleteQuotationItem(index) {
  //   print("Delete at ${index}");
  //   setState(() {
  //     _quotationOrder.quotationItems!.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final appState = Provider.of<ApplicationState>(context);
    final localizations = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width > FormFactor.tablet;
    final isTablet = MediaQuery.of(context).size.width > FormFactor.handset;
    final startPadding = isTablet
        ? 60.0
        : isDesktop
            ? 120.0
            : 0.0;
    final endPadding = isTablet
        ? 30.0
        : isDesktop
            ? 60.0
            : 0.0;

    return Consumer<ApplicationState>(
      builder: (context, appState, _)=> Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: textColor),
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 0,
          actions: [
            Visibility(
              visible: appState.quotationOrder.quotationItems!.isNotEmpty,
              child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        appState.quotationOrder.quotationRequester =
                            quotationRequesterTextController.text;
                        appState.quotationOrder.submissionDate = DateTime.now();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuotationOrderConfirmPage(
                              quotationOrder: appState.quotationOrder,
                              history: false,
                            ),
                          ),
                        );
                        // print(
                        //     'Button NEXT ... ${_quotationOrder.toJson()}');
                      }
                    },
                    child: Icon(
                      Icons.send,
                      size: 26.0,
                    ),
                  )),
            ),
          ],
          // title: Text(
          //   localizations.quoteOrderTitle,
          //   style: EasyQuoteTextStyles.h5,
          // ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                    //   child: Text(
                    //     localizations.quoteOrderPurpose,
                    //     style: textTheme.subtitle1,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: TextFormField(
                        onChanged: (value) async {
                          appState.updateQuotationRequester(value);
                        },
                        controller: quotationRequesterTextController,
                        autofocus: true,
                        decoration: formInputDecoration.copyWith(
                            hintText: localizations.quoteOrderPurposeHint),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localizations.quoteOrderPurposeV;
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                      child: Text(
                        appState.quotationOrder.quotationItems!.isNotEmpty
                            ? '${localizations.quotaOrderItemText} (${appState.quotationOrder.quotationItems!.length})'
                            : localizations.quotaOrderItemText,
                        style: textTheme.subtitle1,
                      ),
                    ),
                    Expanded(
                      child: appState.quotationOrder.quotationItems!.isEmpty
                          ? Center(
                              child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 100, 0, 40),
                                  child: SizedBox(
                                      height: 247,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/icons/box.png"),
                                              fit: BoxFit.fitHeight),
                                        ),
                                        child: Center(child: null),
                                      )),
                                ),
                                Text(localizations.quotaOrderEmpty,
                                    style: textTheme.subtitle1),
                              ],
                            ))
                          : ListView.separated(
                              itemCount: appState.quotationOrder.quotationItems!.length,
                              padding: EdgeInsetsDirectional.only(
                                start: startPadding,
                                end: endPadding,
                                top: isDesktop ? 28 : 0,
                                bottom: kToolbarHeight,
                              ),
                              primary: false,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) =>
                                  QuotationItemPreviewCard(
                                callback: appState.updateQuotationItem,
                                quotationItem:
                                appState.quotationOrder.quotationItems![index],
                                onDelete: () => appState.deleteQuotationItem(index),
                                index: index,
                              ),
                            ),
                    ),

                    //////////////////////////////////
                    //////////////////////////////////
                    // Visibility(
                    //   visible: _quotationOrder.quotationItems!.isNotEmpty,
                    //   child: Padding(
                    //     padding:
                    //         const EdgeInsetsDirectional.fromSTEB(80, 5, 80, 16),
                    //     child: ElevatedButton(
                    //       child: const SizedBox(
                    //         height: 56,
                    //         width: double.infinity,
                    //         child: Center(
                    //           child: Text(
                    //             'Next',
                    //             style:
                    //                 TextStyle(fontSize: 20, color: Colors.white),
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ),
                    //       ),
                    //       style: ElevatedButton.styleFrom(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(20.0),
                    //         ),
                    //         primary: buttonColor,
                    //         elevation: 0,
                    //         shadowColor: Colors.transparent,
                    //       ),
                    //       onPressed: () {
                    //         if (_formKey.currentState!.validate()) {
                    //           _quotationOrder.quotationRequester =
                    //               quotationRequesterTextController.text;
                    //           _quotationOrder.submissionDate = DateTime.now();
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => QuotationOrderConfirmPage(
                    //                 quotationOrder: _quotationOrder,
                    //                 history: false,
                    //               ),
                    //             ),
                    //           );
                    //           // print(
                    //           //     'Button NEXT ... ${_quotationOrder.toJson()}');
                    //         }
                    //         // Navigator.pop(context);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    //////////////////////////////////
                    //////////////////////////////////
                  ]),
            ),
          ),
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: FloatingActionButton.extended(
            backgroundColor: keyColor,
            onPressed: () {
              // appState.selectedIndex = 4;
              setState(() {
                Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return QuotationEditPage(
                        restorationId: 'quotationEdit',
                        callback: appState.addQuotationItem,
                        isEdit: false,
                      );
                    },
                    fullscreenDialog: true));
              });
            },
            elevation: 0,
            icon: Icon(Icons.add),
            label: Text(
              localizations.quotaItemTitleNew,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
