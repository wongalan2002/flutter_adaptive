import 'package:adaptive_app_demos/main.dart';
import '../global/styling.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../application_state.dart';
import '../models/user_profile.dart';

class SettingProfileEditPage extends StatefulWidget {
  const SettingProfileEditPage({Key? key}) : super(key: key);
  @override
  _SettingProfileEditPageState createState() =>
      _SettingProfileEditPageState();
}

class _SettingProfileEditPageState extends State<SettingProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _schoolTextController = TextEditingController();
  final TextEditingController _postTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  late List<bool> isSelected;
  late String locale = "zh";

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final appState = Provider.of<ApplicationState>(context);
    appState.userProfile.name != null
        ? _nameTextController.text = appState.userProfile.name!
        : _nameTextController.text = '';
    appState.userProfile.schoolName != null
        ? _schoolTextController.text = appState.userProfile.schoolName!
        : _schoolTextController.text = '';
    appState.userProfile.post != null
        ? _postTextController.text = appState.userProfile.post!
        : _postTextController.text = '';
    appState.userProfile.email != null
        ? _emailTextController.text = appState.userProfile.email!
        : _emailTextController.text = '';
    appState.userProfile.phone != null
        ? _phoneTextController.text = appState.userProfile.phone!
        : _phoneTextController.text = '';
    if (appState.userProfile.locale != null) {
      if (appState.userProfile.locale == "zh") {
        isSelected = [true, false];
        locale = "zh";
      }
      if (appState.userProfile.locale == "en") {
        isSelected = [false, true];
        locale = "en";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,color: textColor,),
            onPressed: () => Navigator.pop(context, false),
          ),
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          title: Text(
            localizations.userInfoTitle,
            style: EasyQuoteTextStyles.h5,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    height: 30,
                    child: Text(
                      localizations.userInfoName,
                      style: EasyQuoteTextStyles.subtitle,
                    ),
                  ),
                  TextFormField(
                    controller: _nameTextController,
                    decoration:
                    formInputDecoration.copyWith(hintText: 'Your Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your name to continue';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                    child: Text(
                      localizations.userInfoSchoolName,
                      style: EasyQuoteTextStyles.subtitle,
                    ),
                  ),
                  TextFormField(
                    controller: _schoolTextController,
                    decoration: formInputDecoration.copyWith(
                        hintText: 'Enter your school name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your school name to continue';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                    child: Text(
                      localizations.userInfoPost,
                      style: EasyQuoteTextStyles.subtitle,
                    ),
                  ),
                  TextFormField(
                    controller: _postTextController,
                    decoration: formInputDecoration.copyWith(
                        hintText: 'Enter your post'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your post to continue';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                    child: Text(
                      localizations.userInfoPhone,
                      style: EasyQuoteTextStyles.subtitle,
                    ),
                  ),
                  TextFormField(
                    controller: _phoneTextController,
                    decoration: formInputDecoration.copyWith(
                        hintText: 'Enter your phone'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your phone to continue';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                    child: Text(
                      localizations.userInfoEmail,
                      style: EasyQuoteTextStyles.subtitle,
                    ),
                  ),
                  TextFormField(
                    controller: _emailTextController,
                    style: const TextStyle(color: inactiveBackgroundColor),
                    decoration: formInputDecoration.copyWith(enabled: false),
                  ),
                  ToggleButtons(
                    // borderColor: Colors.black,
                    // fillColor: Colors.grey,
                    // borderWidth: 2,
                    // selectedBorderColor: Colors.black,
                    // selectedColor: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    children:  const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '中文',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'English',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        if (index == 0) {
                          {
                            isSelected = [true, false];
                            App.setLocale(context, const Locale('zh', ''));
                            locale = "zh";
                          }
                        }
                        if (index == 1) {
                          {
                            isSelected = [false, true];
                            App.setLocale(context, const Locale('en', ''));
                            locale = "en";
                          }
                        }
                      });
                    },
                    isSelected: isSelected,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(height: 56),
                      child: ElevatedButton(
                        child: const Text(
                          'SAVE',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          primary: buttonColor,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            appState.userProfile = UserProfile(
                                name: _nameTextController.text,
                                schoolName: _schoolTextController.text,
                                post: _postTextController.text,
                                phone: _phoneTextController.text,
                                email: _emailTextController.text,
                                locale: locale,
                                id:appState.userProfile.id!);

                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
