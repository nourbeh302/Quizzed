import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/auth.dart';
import 'package:quizzed/widgets/quizzed_appbar.dart';
import 'package:quizzed/widgets/quizzed_navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? loggedInUser = Auth().loggedInUser;

  Future<void> signOut() async {
    await Auth().signOut();
    navigateToGettingStartedScreen();
  }

  void navigateToGettingStartedScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, '/gettingStarted', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const QuizzedAppBar(
          title: "Home",
          isBackButtonActive: false,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome ${Auth().loggedInUser?.email}',
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                  onPressed: () => signOut(),
                  child: Text('Sign out',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const QuizzedNavbar());
  }
}
