import '../global/styling.dart';
import 'quotation_order_list_page.dart';
import 'start_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuotationOrderSent extends StatelessWidget {
  const QuotationOrderSent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  '等候報價',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                  child: Text(
                    '請等待報價回覆',
                    textAlign: TextAlign.center,
                  )),
              Row(
                mainAxisAlignment : MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: SvgPicture.asset(
                      "assets/images/rocket.svg",),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  /////////////////////
                  // MUST EDIT THIS

                  // Navigator.of(context).pop();
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (BuildContext context) =>
                  //         QuotationOrderListPage(quotationTitle: '',)));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: activeBackgroundColor,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: const SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      '查看報價',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const StartPage()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: buttonColor,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: const SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      '返回主頁',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
