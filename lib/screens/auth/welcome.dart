import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 64.0, 0, 64.0),
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset('assets/images/larry-08.png'),
                    ),
                  ),
                  Text(
                    "Get started with Quizzed",
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Unlock your knowledge potential with our quiz management app. Login now and start creating, managing, and acing your quizzes!",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: Text('Get started',
                    style: Theme.of(context).textTheme.labelMedium),
              )
            ],
          ),
        ),
      ),
    );
  }
}
