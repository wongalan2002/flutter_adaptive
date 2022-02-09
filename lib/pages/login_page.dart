import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../widgets/show_error.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLogin = true;

  void showLoginPage() {
    setState(() {
      showLogin = true;
    });
  }

  void showRegisterPage() {
    setState(() {
      showLogin = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool useVerticalLayout = screenSize.width < screenSize.height;
    bool hideDetailPanel = screenSize.shortestSide < 250;

    return Scaffold(
      body: Flex(
          direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
          children: [
            if (hideDetailPanel == false) ...[
              Flexible(child: _LoginDetailPanel()),
            ],
            Flexible(
                flex: useVerticalLayout ? 2 : 1,
                child: showLogin
                    ? _LoginForm(showRegister: showRegisterPage)
                    : _RegisterForm(showLogin: showLoginPage))
          ]),
    );
  }
}

class _LoginDetailPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        color: Colors.grey.shade300,
        child: Text(
          "EASY\nQUOTE",
          style: TextStyle(fontSize: 64),
          textAlign: TextAlign.center,
        ),
      );
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({required this.showRegister});
  final void Function() showRegister;
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ShowError showError = new ShowError();

  @override
  Widget build(BuildContext context) {
    void handleLoginPressed(email, password) =>
        context.read<ApplicationState>().signInWithEmailAndPassword(email,
            password, (e) => showError.showErrorDialog(context, "title", e));
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 450),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email to continue';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          handleLoginPressed(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                      // onPressed: handleLoginPressed,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: Text("Log In"),
                      )),
                  SizedBox(height: 50),
                  RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: "Don't have an account? ",
                          style: new TextStyle(color: Colors.black),
                        ),
                        new TextSpan(
                          text: 'Sign up',
                          style: new TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              widget.showRegister();
                            },
                        ),
                      ],
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

class _RegisterForm extends StatefulWidget {
  const _RegisterForm({required this.showLogin});
  final void Function() showLogin;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final ShowError showError = new ShowError();

  @override
  Widget build(BuildContext context) {
    void handleRegisterPressed(email, password) =>
        context.read<ApplicationState>().registerAccount(email, password,
            (e) => showError.showErrorDialog(context, "title", e));
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 450),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your email to continue';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordConfirmController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Password not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          handleRegisterPressed(
                            _emailController.text,
                            _passwordConfirmController.text,
                          );
                        }
                      },
                      // onPressed: handleLoginPressed,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: Text("REGISTER"),
                      )),
                  SizedBox(height: 50),
                  RichText(
                    text: new TextSpan(
                      children: [
                        new TextSpan(
                          text: "Already have an account? ",
                          style: new TextStyle(color: Colors.black),
                        ),
                        new TextSpan(
                          text: 'Login',
                          style: new TextStyle(color: Colors.blue),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              widget.showLogin();
                            },
                        ),
                      ],
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
