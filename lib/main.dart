import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/constant.dart';
import 'package:quizzed/screens/getting_started_screen.dart';

import 'package:quizzed/screens/home_screen.dart';
import 'package:quizzed/screens/login_screen.dart';
import 'package:quizzed/screens/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          snackBarTheme: SnackBarThemeData(
            backgroundColor: primaryColor,
            contentTextStyle:
                TextStyle(fontSize: 16, fontFamily: baseFontFamily),
          ),
          appBarTheme: defaultAppBarTheme,
          elevatedButtonTheme: elevatedButtonThemeData,
          outlinedButtonTheme: outlinedButtonThemeData,
          fontFamily: baseFontFamily,
          scaffoldBackgroundColor: Colors.amber.shade50,
          textTheme: defaultTextTheme),
      title: _title,
      initialRoute: '/gettingStarted',
      routes: {
        '/': (context) => const HomeScreen(),
        '/gettingStarted': (context) => const GettingStartedScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
