import 'package:flutter/material.dart';
import 'package:quizzed/helpers/format_date.dart';
import 'package:quizzed/models/quiz.dart';
import 'package:quizzed/providers/auth_provider.dart';

class StartQuizScreen extends StatelessWidget {
  const StartQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = ModalRoute.of(context)!.settings.arguments as Quiz;
    final formatter = TimestampFormatter();

    final AuthProvider authProvider = AuthProvider();

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
            const SizedBox(
              height: 8.0,
            ),
            Text(formatter.formatTimestamp(quiz.createdAt)),
            Text('Duration: ${quiz.duration} min(s)'),
            Text('Number of questions: ${quiz.questionCount}'),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () async {
                      var user = await authProvider.getFireStoreUser();
                      if ((user!.isProfessor)) {
                        // ignore: use_build_context_synchronously
                        showErrorDialog(context);
                        return;
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(
                        context,
                        '/questions',
                        arguments: quiz,
                      );
                    },
                    child: Text(
                      'Start Quiz',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox.shrink(),
                ), // Empty row slot
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Professor cannot take quizzes',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }
}
