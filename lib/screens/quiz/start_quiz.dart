import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizzed/helpers/format_date.dart';
import 'package:quizzed/models/quiz.dart';

class StartQuizScreen extends StatelessWidget {
  const StartQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = ModalRoute.of(context)!.settings.arguments as Quiz;
    final formatter = TimestampFormatter();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(quiz.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz.title,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(formatter.formatTimestamp(quiz.createdAt)),
            Text('Duration: ${quiz.duration} min(s)'),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () => log('Start Quiz'),
                    child: Text('Start Quiz',
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                ),
                const Expanded(
                    flex: 1, child: SizedBox.shrink()), // Empty row slot
              ],
            )
          ],
        ),
      ),
    );
  }
}
