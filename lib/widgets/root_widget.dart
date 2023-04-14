import 'package:flutter/widgets.dart';
import 'package:quizzed/models/auth.dart';
import 'package:quizzed/screens/shared/getting_started_screen.dart';
import 'package:quizzed/screens/shared/home_screen.dart';

class RootWidget extends StatefulWidget {
  const RootWidget({super.key});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  bool isUserLoggedIn = false;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const GettingStartedScreen();
          }
        });
  }
}
