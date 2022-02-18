import 'package:provider/provider.dart';

import '../application_state.dart';
import '../global/device_size.dart';
import '../widgets/ok_cancel_textfield_dialog.dart';
import 'quotation_order_comfirm_page.dart';
import 'quotation_edit_page.dart';
import 'quotation_item_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../global/styling.dart';

class QuotationOrderListPage extends StatefulWidget {
  QuotationOrderListPage({Key? key, required this.quotationTitle})
      : super(key: key);
  String quotationTitle;

  @override
  _QuotationOrderListPageState createState() => _QuotationOrderListPageState();
}

class _QuotationOrderListPageState extends State<QuotationOrderListPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController quotationRequesterTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void updateQuotationTitle(String value) {
    setState(() {
      widget.quotationTitle = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final localizations = AppLocalizations.of(context)!;
    final isDesktop = MediaQuery.of(context).size.width > FormFactor.tablet;
    final isTablet = MediaQuery.of(context).size.width > FormFactor.handset;
    final startPadding = isTablet
        ? 0.0
        : isDesktop
            ? 120.0
            : 0.0;
    final endPadding = isTablet
        ? 0.0
        : isDesktop
            ? 60.0
            : 0.0;

    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Scaffold(
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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.quotationTitle,
                              style: EasyQuoteTextStyles.h5,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                String message = "報價單名稱";
                                showDialog(
                                    context: context,
                                    builder: (_) => OkCancelTextFieldDialog(
                                          callback: updateQuotationTitle,
                                          quotationItem: widget.quotationTitle,
                                          message: message,
                                          isEdit: true,
                                        ));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: inactiveBackgroundColor,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                      child: Center(
                        child: Text(
                          appState.quotationOrder.quotationItems!.isNotEmpty
                              ? '${localizations.quotaOrderItemText} (${appState.quotationOrder.quotationItems!.length})'
                              : localizations.quotaOrderItemText,
                          style: textTheme.subtitle1,
                        ),
                      ),
                    ),
                    appState.quotationOrder.quotationItems!.isEmpty
                        ? Expanded(
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 50, 0, 40),
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
                                Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 100),
                                    child: Text(localizations.quotaOrderEmpty,
                                        style: textTheme.subtitle1),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 14.0,
                                      offset: Offset(0, 4))
                                ],
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: appState
                                  .quotationOrder.quotationItems!.length,
                              padding: EdgeInsetsDirectional.only(
                                start: startPadding,
                                end: endPadding,
                                top: isDesktop ? 28 : 0,
                                bottom: 0,
                              ),
                              primary: false,
                              separatorBuilder: (context, index) => Divider(
                                color: dimGrey,
                              ),
                              itemBuilder: (context, index) =>
                                  QuotationItemPreviewCard(
                                callback: appState.updateQuotationItem,
                                quotationItem: appState
                                    .quotationOrder.quotationItems![index],
                                onDelete: () =>
                                    appState.deleteQuotationItem(index),
                                index: index,
                              ),
                            ),
                          ),
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
