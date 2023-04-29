import 'package:flutter/material.dart';
import 'package:quizzed/constant.dart';

class MyThemeData {
  ThemeData getTheme() {
    return ThemeData(
      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: primaryColor,
        color: scaffoldColor,
        linearMinHeight: 64.0
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: primaryColor,
        contentTextStyle: TextStyle(fontSize: 16, fontFamily: baseFontFamily),
      ),
      appBarTheme: defaultAppBarTheme,
      elevatedButtonTheme: elevatedButtonThemeData,
      outlinedButtonTheme: outlinedButtonThemeData,
      fontFamily: baseFontFamily,
      scaffoldBackgroundColor: Colors.amber.shade50,
      textTheme: defaultTextTheme,
    );
  }
}
