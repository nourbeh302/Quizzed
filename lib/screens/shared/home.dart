import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/services/auth_service.dart';
import 'package:quizzed/widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final User? loggedInUser = AuthService().loggedInUser;

  Future<void> signOut() async {
    await _authService.signOut();
    navigateToWelcomeScreen();
  }

  void navigateToWelcomeScreen() =>
      Navigator.pushNamedAndRemoveUntil(context, '/Welcome', (route) => false);

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
                'Welcome ${loggedInUser?.email ?? 'Professor'}',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              OutlinedButton(
                onPressed: () => signOut(),
                child: Text('Sign out',
                    style: Theme.of(context).textTheme.labelMedium),
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/courses'),
                child: Text('View courses',
                    style: Theme.of(context).textTheme.labelMedium),
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/addCourse'),
                child: Text('Add new course',
                    style: Theme.of(context).textTheme.labelMedium),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
