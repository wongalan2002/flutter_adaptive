import 'dart:io';
import 'package:animations/animations.dart';
import '../global/device_size.dart';
import '../global/styling.dart';
import '../models/quotation_item.dart';
// import 'package:easyquote/src/adaptive.dart';
import 'quotation_edit_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuotationItemPreviewCard extends StatefulWidget {
  QuotationItemPreviewCard(
      {Key? key,
        required this.quotationItem,
        required this.onDelete,
        required this.index,
        required this.callback})
      : super(key: key);
  QuotationItem quotationItem;
  Function onDelete;
  final Function(int index, QuotationItem newValue, bool deleteThis) callback;
  int index;

  @override
  State<QuotationItemPreviewCard> createState() =>
      _QuotationItemPreviewCardState();
}

class _QuotationItemPreviewCardState extends State<QuotationItemPreviewCard> {
  void callback(int index, QuotationItem newValue, bool deleteThis) {
    widget.callback(index, newValue, deleteThis);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return QuotationEditPage(
          callback: callback,
          quotationItem: widget.quotationItem,
          quotationItemIndex: widget.index,
          isEdit: true,
        );
      },
      openColor: theme.cardColor,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      closedElevation: 3,
      closedColor: theme.cardColor,
      closedBuilder: (context, openContainer) {
        final isDesktop = MediaQuery.of(context).size.width > FormFactor.tablet;
        final colorScheme = theme.colorScheme;
        final quotationItemPreview = _QuotationItemPreview(
          quotationItem: widget.quotationItem,
          onTap: openContainer,
          onDelete: widget.onDelete,
        );
        if (isDesktop) {
          return quotationItemPreview;
        } else {
          return Dismissible(
            key: ObjectKey(widget.quotationItem),
            dismissThresholds: const {
              DismissDirection.startToEnd: 0.8,
              DismissDirection.endToStart: 0.8,
            },
            onDismissed: (direction) {
              switch (direction) {
                case DismissDirection.endToStart:
                  widget.onDelete();
                  break;
                case DismissDirection.startToEnd:
                  widget.onDelete();
                  break;
                default:
              }
            },
            background: _DismissibleContainer(
              backgroundColor: colorScheme.primary,
              iconColor: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsetsDirectional.only(start: 0),
            ),
            confirmDismiss: (direction) async {
              switch (direction) {
                case DismissDirection.endToStart:
                  widget.onDelete();
                  break;
                case DismissDirection.startToEnd:
                  widget.onDelete();
                  break;
                default:
              }
            },
            secondaryBackground: _DismissibleContainer(
              iconColor: Colors.red,
              backgroundColor: colorScheme.primary,
              alignment: Alignment.centerRight,
              padding: const EdgeInsetsDirectional.only(end: 0),
            ),
            child: quotationItemPreview,
          );
        }
      },
    );
  }
}

class _DismissibleContainer extends StatelessWidget {
  const _DismissibleContainer({
    required this.backgroundColor,
    required this.iconColor,
    required this.alignment,
    required this.padding,
  });

  final Color backgroundColor;
  final Color iconColor;
  final Alignment alignment;
  final EdgeInsetsDirectional padding;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: alignment,
      curve: standardEasing,
      color: Colors.red,
      duration: kThemeAnimationDuration,
      padding: padding,
      child: const Material(
        color: Colors.transparent,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _QuotationItemPreview extends StatelessWidget {
  const _QuotationItemPreview({
    required this.quotationItem,
    required this.onTap,
    this.onDelete,
  });

  final QuotationItem quotationItem;
  final VoidCallback onTap;
  final onDelete;

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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                  quotationItem.itemName!,
                                  style: EasyQuoteTextStyles.h5,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,),
                            ),
                            Row(
                              children: [
                                Text(
                                  quotationItem.quantity.toString(),
                                  style: EasyQuoteTextStyles.h6,
                                ),
                                SizedBox(width: 2),
                                if (quotationItem.unit.toString() ==
                                    'null') ...[
                                  Text(
                                    "",
                                    style: EasyQuoteTextStyles.h6,
                                  )
                                ] else ...[
                                  Text(
                                    quotationItem.unit.toString(),
                                    style: EasyQuoteTextStyles.h6,
                                  ),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ),
                      _QuotationItemPreviewActionBar(
                        onDelete: onDelete,
                      ),
                    ],
                  ),
                  if (quotationItem.description!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 20,
                      ),
                      child: Text(
                        quotationItem.description!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.bodyText2,
                      ),
                    ),
                  ],
                  if (quotationItem.imageFileList!.isNotEmpty) ...[
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          _PicturePreview(quotationItem),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PicturePreview extends StatelessWidget {
  _PicturePreview(this.quotationItem);

  QuotationItem quotationItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        itemCount: quotationItem.imageFileList!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 100,
            child: Align(
              alignment: const AlignmentDirectional(0, 0),
              child: kIsWeb
                  ? Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          quotationItem.imageFileList![index].path),
                      fit: BoxFit.cover,
                    )),
              )
                  : Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                          File(quotationItem.imageFileList![index].path)),
                      fit: BoxFit.cover,
                    )),
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
