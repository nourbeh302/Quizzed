import 'package:flutter/material.dart';

// Colors
Color scaffoldColor = const Color(0xFFF7F0E5);
Color primaryColor = const Color.fromARGB(255, 155, 129, 193);
Color secondaryColor = const Color(0xFF1D1D1D);
Color mutedColor = const Color(0xFF525252);
// Color errorColor = const Color(0xFFEF5350);
// ----------------

// Padding
EdgeInsets buttonPadding =
    const EdgeInsets.symmetric(horizontal: 32, vertical: 12);
// ----------------

// Fonts

double appBarFontSize = 24.0;
double inputFontSize = 20.0;
double buttonFontSize = 16.0;
double linkFontSize = 14.5;
double errorFontSize = 14.5;

String baseFontFamily = 'MabryPro';
// ----------------

OutlinedButtonThemeData outlinedButtonThemeData = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    elevation: 0,
    minimumSize: const Size.fromHeight(32),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: const StadiumBorder(),
    side: const BorderSide(width: 1),
  ),
);

// ElevatedButtonTheme elevatedButtonTheme = ElevatedButtonTheme(
//   data: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       elevation: 0,
//       backgroundColor: primaryColor,
//       minimumSize: const Size.fromHeight(32),
//       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//       shape: const StadiumBorder(),
//     ),
//   ),
//   child: Text("", style: TextStyle(color: scaffoldColor)),
// );

AppBar createAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: primaryColor,
    foregroundColor: secondaryColor,
  );
}

ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: primaryColor,
    minimumSize: const Size.fromHeight(32),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: const StadiumBorder(),
  ),
);

AppBarTheme defaultAppBarTheme = AppBarTheme(
  backgroundColor: primaryColor,
);

TextTheme defaultTextTheme = const TextTheme(
  displayLarge: TextStyle(
    color: Colors.black,
    fontSize: 36.0,
    fontWeight: FontWeight.w700,
  ),
  displayMedium: TextStyle(
    color: Colors.black,
    fontSize: 18.0,
  ),
  displaySmall: TextStyle(color: Colors.indigo),
  bodySmall: TextStyle(
    color: Colors.grey,
    fontSize: 18.0,
  ),
  bodyMedium: TextStyle(
    color: Colors.black,
    fontSize: 18.0,
  ),
  bodyLarge: TextStyle(
    color: Colors.indigo,
  ),
);
