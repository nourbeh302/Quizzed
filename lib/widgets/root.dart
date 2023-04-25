import 'package:flutter/widgets.dart';
import 'package:quizzed/screens/shared/welcome.dart';
import 'package:quizzed/screens/shared/home.dart';
import 'package:quizzed/providers/auth_provider.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  bool isUserLoggedIn = false;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AuthProvider().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const WelcomeScreen();
          }
        });
  }
}
