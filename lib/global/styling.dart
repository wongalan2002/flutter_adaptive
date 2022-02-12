import 'package:flutter/material.dart';

class Insets {
  static double medium = 5;
  static double large = 10;
  static double extraLarge = 20;
  static double small = 3;
}

class TextStyles {
  static TextStyle buttonText1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
  static TextStyle buttonText2 = TextStyle(fontWeight: FontWeight.normal, fontSize: 11);
  static TextStyle h1 = TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  static TextStyle h2 = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
}

const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFDDDDDD);
const redColor = Color(0xFFE85050);
const inactiveBackgroundColor = Color(0xFFCCCCCC);
const activeBackgroundColor = Color(0xFF9C6DFF);
const buttonColor = Colors.black;
const mainSessionButton = Color(0xFFC4C4C4);
const defaultPadding = 16.0;
const keyColor = Color(0XFF6732FF);
const CCC = Color(0XFFCCCCCC);

InputDecoration formInputDecoration = InputDecoration(
  filled: true,
  helperText: '',
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.all(8.0),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: activeBackgroundColor),
    borderRadius: BorderRadius.circular(8.0),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: const BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(8.0),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.white),
    borderRadius: BorderRadius.circular(8.0),
  ),
  border: OutlineInputBorder(
    borderSide: const BorderSide(color: activeBackgroundColor),
    borderRadius: BorderRadius.circular(8.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: redColor),
    borderRadius: BorderRadius.circular(8.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: redColor),
    borderRadius: BorderRadius.circular(8.0),
  ),
  hintStyle: const TextStyle(
    color: Color(0xAD9A9A9A),
  ),
);
