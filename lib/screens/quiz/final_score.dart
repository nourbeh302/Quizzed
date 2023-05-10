import 'package:flutter/material.dart';
import 'package:quizzed/providers/score_provider.dart';

class FinalScoreScreen extends StatefulWidget {
  const FinalScoreScreen({super.key});

  @override
  State<FinalScoreScreen> createState() => _FinalScoreScreenState();
}

class _FinalScoreScreenState extends State<FinalScoreScreen> {
  ScoreProvider scoreProvider = ScoreProvider();

  @override
  Widget build(BuildContext context) {
    final List<int> grades =
        ModalRoute.of(context)!.settings.arguments as List<int>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Score'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your final score: ${(grades.first / grades.last) * 100}%',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'Congratulations on finishing the exam! You should be proud of yourself for your hard work and dedication.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Expanded(
              child: SizedBox.expand(),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              },
              child: Text(
                'Go home',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
