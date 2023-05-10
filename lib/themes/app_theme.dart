import 'package:flutter/material.dart';
import 'package:quizzed/constant.dart';

class MyThemeData {
  ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: primaryColor,
        onPrimaryContainer: const Color.fromARGB(255, 119, 84, 136),
        secondary: secondaryColor,
        onSecondaryContainer: secondaryColor,
        surface: Colors.white,
        background: Colors.white,
        error: const Color(0xFFB00020),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: primaryColor,
        color: scaffoldColor,
        linearMinHeight: 64.0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: primaryColor,
        contentTextStyle: TextStyle(
          fontSize: 16,
          fontFamily: baseFontFamily,
        ),
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
