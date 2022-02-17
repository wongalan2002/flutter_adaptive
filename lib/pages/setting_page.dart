import '../widgets/ok_cancel_dialog.dart';
import 'setting_profile_edit_page.dart';
import '../global/styling.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:adaptive_app_demos/application_state.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    // final items = [
    //   localizations.settingTitleLanguage,
    //   localizations.settingTitlePersonalInfo,
    //   localizations.settingTitleFAQ,
    //   localizations.settingTitleTerms,
    //   localizations.settingTitleAboutUs,
    //   localizations.settingTitleLogout];
    void _handleLogoutPressed() async {
      String message = "Are you sure you want to logout?";
      bool? doLogout = await showDialog(
          context: context, builder: (_) => OkCancelDialog(message: message));
      if (doLogout ?? false) {
        context.read<ApplicationState>().reset();
        context.read<ApplicationState>().signOut();
        // context.read<AppModel>().logout();
      }
    }

    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.settingTitle,
            style: EasyQuoteTextStyles.h5,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                Container(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                      child: Text(
                        localizations.settingTitleLanguage,
                        style: EasyQuoteTextStyles.subtitle,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                          BorderSide(width: 1, color: mainSessionButton)),
                    )),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const SettingProfileEditPage()),
                    );
                  },
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                        child: Text(
                          localizations.settingTitlePersonalInfo,
                          style: EasyQuoteTextStyles.subtitle,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(width: 1, color: mainSessionButton)),
                      )),
                ),
                InkWell(
                  onTap: () {
                  },
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                        child: Text(
                          localizations.settingTitleFAQ,
                          style: EasyQuoteTextStyles.subtitle,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(width: 1, color: mainSessionButton)),
                      )),
                ),
                InkWell(
                  onTap: () {
                  },
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                        child: Text(
                          localizations.settingTitleTerms,
                          style: EasyQuoteTextStyles.subtitle,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(width: 1, color: mainSessionButton)),
                      )),
                ),
                InkWell(
                  onTap: () {
                  },
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                        child: Text(
                          localizations.settingTitleAboutUs,
                          style: EasyQuoteTextStyles.subtitle,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(width: 1, color: mainSessionButton)),
                      )),
                ),
                InkWell(
                  onTap: () {
                    _handleLogoutPressed();
                  },
                  child: Container(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 15),
                        child: Text(
                          localizations.settingTitleLogout,
                          style: EasyQuoteTextStyles.subtitle,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(width: 1, color: mainSessionButton)),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
