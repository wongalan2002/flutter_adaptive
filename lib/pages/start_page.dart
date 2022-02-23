import 'package:adaptive_app_demos/widgets/ok_cancel_textfield_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import '../global/styling.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          title: Text(
            "HAPPY"
            // AppLocalizations.of(context)!.appName,
            // style: EasyQuoteTextStyles.h5.copyWith(color: secKeyColor),
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
              onTap: () async {
                String message = "報價單名稱";
                await showDialog(
                    context: context,
                    builder: (_) => OkCancelTextFieldDialog(
                          message: message,
                          isEdit: false,
                        ));
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

              ]),
        ));
  }
}
