import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kBackgroundColor,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kPrimaryColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  );
}

InputDecoration inputForm(String label, String hint) {
  return InputDecoration(
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.teal),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor),
    ),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: kHintTextColor)),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.teal),
    ),
    disabledBorder: InputBorder.none,
    fillColor: kSecondaryColor,
    hoverColor: kSecondaryColor,
    focusColor: kSecondaryColor,
    labelText: label,
    hintText: hint,
    hintStyle: TextStyle(color: kHintTextColor),
    labelStyle: TextStyle(color: kSecondaryColor),
// If  you are using latest version of flutter then lable text and hint text shown like this
// if you r using flutter less then 1.20.* then maybe this is not working properly
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: EdgeInsets.only(left: 15, bottom: 11, right: 15),
  );
}
