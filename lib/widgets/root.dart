import 'package:flutter/widgets.dart';
import 'package:quizzed/screens/shared/welcome.dart';
import 'package:quizzed/screens/shared/home.dart';
import 'package:quizzed/services/auth_service.dart';

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
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const WelcomeScreen();
          }
        });
  }
}
