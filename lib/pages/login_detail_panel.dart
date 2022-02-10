import 'package:flutter/material.dart';

class LoginDetailPanel extends StatelessWidget {
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