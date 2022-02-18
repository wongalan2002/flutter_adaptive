import 'package:animations/animations.dart';
import '../global/device_size.dart';
import '../models/quotation_order.dart';
// import 'package:easyquote/src/adaptive.dart';
import 'quotation_order_comfirm_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quotation_order.dart';
import '../global/styling.dart';
import 'package:adaptive_app_demos/application_state.dart';

class QuotationsListPage extends StatefulWidget {
  const QuotationsListPage({Key? key}) : super(key: key);

  @override
  _QuotationsListPageState createState() => _QuotationsListPageState();
}

class _QuotationsListPageState extends State<QuotationsListPage> {
  late List<QuotationOrder> _quotationOrders;

  @override
  void didChangeDependencies() {
    final appState = Provider.of<ApplicationState>(context);
    _quotationOrders = appState.quotationOrders;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > FormFactor.tablet;
    final isTablet = MediaQuery.of(context).size.width > FormFactor.handset;
    final startPadding = isTablet
        ? 0.0
        : isDesktop
        ? 120.0
        : 4.0;
    final endPadding = isTablet
        ? 0.0
        : isDesktop
        ? 60.0
        : 4.0;

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: textColor),
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: true,
          centerTitle: false,
          elevation: 0,
          title: Text(
            '報價',
            style: EasyQuoteTextStyles.h5,
          ),
        ),
        body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 72,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                width: 100, height: 56),
                            child: ElevatedButton(
                              child: const Text(
                                ' 待報價',
                                style: TextStyle(fontSize: 16, color: textColor),
                              ),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                primary: mainSessionButton,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                width: 100, height: 56),
                            child: ElevatedButton(
                              child: const Text(
                                '紀錄',
                                style: TextStyle(fontSize: 16, color: textColor),
                              ),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                primary: Colors.transparent,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _quotationOrders.isEmpty
                        ? const Center(child: Text('Empty in Quotation History'))
                        : ListView.separated(
                      itemCount: _quotationOrders.length,
                      padding: EdgeInsetsDirectional.only(
                        start: startPadding,
                        end: endPadding,
                        top: isDesktop ? 28 : 0,
                        bottom: kToolbarHeight,
                      ),
                      primary: false,
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return _QuotationOrderCard(
                          quotationOrder: _quotationOrders[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}

class _QuotationOrderCard extends StatelessWidget {
  late QuotationOrder quotationOrder;
  int index;
  _QuotationOrderCard({required this.quotationOrder, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OpenContainer(
        openBuilder: (context, openContainer) {
          return QuotationOrderConfirmPage(
            quotationOrder: quotationOrder,
            history: true,
          );
        },
        openColor: theme.cardColor,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        closedElevation: 0,
        closedColor: theme.cardColor,
        closedBuilder: (context, openContainer) {
          final quotationOrderCardPreview = _QuotationOrderCardPreview(
              id: index,
              onTap: openContainer,
              myQuotationOrder: quotationOrder);
          return quotationOrderCardPreview;
        });
  }
}

class _QuotationOrderCardPreview extends StatelessWidget {
  QuotationOrder myQuotationOrder;
  final VoidCallback onTap;
  final int id;

  _QuotationOrderCardPreview(
      {required this.myQuotationOrder, required this.onTap, required this.id});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${myQuotationOrder.submissionDate?.year.toString()}-"
                                  "${myQuotationOrder.submissionDate?.month.toString().padLeft(2, '0')}-"
                                  "${myQuotationOrder.submissionDate?.day.toString().padLeft(2, '0')}  "
                                  "${myQuotationOrder.submissionDate?.hour.toString().padLeft(2, '0')}:"
                                  "${myQuotationOrder.submissionDate?.minute.toString().padLeft(2, '0')}",
                              style: textTheme.caption,
                            ),
                            const SizedBox(height: 4),
                            Text(myQuotationOrder.quotationRequester!,
                                style: textTheme.headline5),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.more_vert,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 20,
                    ),
                    child: Text(
                      '項目 (${myQuotationOrder.quotationItems!.length})',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: textTheme.bodyText2,
                    ),
                  ),
                  // if (email.containsPictures) ...[
                  //   Flexible(
                  //     fit: FlexFit.loose,
                  //     child: Column(
                  //       children: const [
                  //         SizedBox(height: 20),
                  //         _PicturePreview(),
                  //       ],
                  //     ),
                  //   ),
                  // ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class _QuotationItemPreviewActionBar extends StatelessWidget {
  _QuotationItemPreviewActionBar({
    Key? key,
    this.onDelete,
  }) : super(key: key);

  VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > FormFactor.tablet;
    return Row(
      children: [
        if (isDesktop) ...[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 12),
        ],
      ],
    );
  }
}