import 'package:flutter/material.dart';
// import 'package:quizzed/screens/home_screen.dart';
import 'package:quizzed/screens/login_screen.dart';
import 'package:quizzed/screens/register_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/login',
      routes: {
        // '/': (context) => const HomeWidget(),
        '/login': (context) => const LoginWidget(),
        '/register': (context) => const RegisterWidget(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
