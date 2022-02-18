import 'package:adaptive_app_demos/global/device_type.dart';
import 'package:adaptive_app_demos/global/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../pages/quotation_order_list_page.dart';

class OkCancelTextFieldDialog extends StatefulWidget {
  OkCancelTextFieldDialog({
    Key? key,
    this.callback,
    this.quotationItem,
    required this.message,
    required this.isEdit,
  }) : super(key: key);
  final String message;
  final bool isEdit;
  Function? callback;
  String? quotationItem;

  @override
  State<OkCancelTextFieldDialog> createState() =>
      _OkCancelTextFieldDialogState();
}

class _OkCancelTextFieldDialogState extends State<OkCancelTextFieldDialog> {
  late TextEditingController itemTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      widget.quotationItem != null
          ? itemTextController.text = widget.quotationItem!
          : itemTextController.text = "";
    }
  }

  @override
  void dispose() {
    itemTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: EdgeInsets.all(Insets.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.message,
                style: EasyQuoteTextStyles.h6,
              ),
              SizedBox(height: Insets.large),
              Form(
                key: _formKey,
                child: TextFormField(
                  autofocus: true,
                  controller: itemTextController,
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
              Row(
                children: [
                  Spacer(),
                  Row(
                    children: [
                      DialogButton(
                          label: "Cancel",
                          onPressed: () => Navigator.pop(context, false)),
                      DialogButton(
                          label: widget.isEdit ? "Update" : "OK",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (widget.isEdit == true) {
                                Navigator.pop(context);
                                widget.callback!(itemTextController.text);
                              } else {
                                Navigator.pop(context, false);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          QuotationOrderListPage(
                                            quotationTitle:
                                                itemTextController.text,
                                          )),
                                );
                              }
                            }
                          }),
                    ],
                  ),
                ],
              ),
              // OkCancelButtons(quotationTitle: textController.text,),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(label),
        ));
  }
}