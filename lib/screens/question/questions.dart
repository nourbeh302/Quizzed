import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/constant.dart';
import 'package:quizzed/models/question.dart';
import 'package:quizzed/models/quiz.dart';
import 'package:quizzed/providers/question_provider.dart';
import 'package:quizzed/providers/quiz_provider.dart';
import 'package:quizzed/providers/score_provider.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  String _choice = '';
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Quiz quiz = ModalRoute.of(context)!.settings.arguments as Quiz;
    QuizProvider quizProvider = QuizProvider();
    QuestionProvider questionProvider = QuestionProvider();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Questions'),
            Text('Score: ${Provider.of<ScoreProvider>(context).score}')
          ],
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<String?>(
        future: quizProvider.getQuizIdByTitle(quiz.title),
        builder: (context, snapshot) {
          var quizId = snapshot.data ?? '';

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          return StreamBuilder<List<Question>>(
            stream: questionProvider.getAllQuestions(quizId),
            builder: (context, snapshot) {
              var questions = snapshot.data ?? [];

              return PageView.builder(
                controller: _pageController,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index + 1}. ${questions[index].body}',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            ListTile(
                              tileColor: scaffoldColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                side: BorderSide(
                                  color: primaryColor,
                                  width: 1.4,
                                ),
                              ),
                              selected: _choice == 'T',
                              title: const Text('True'),
                              onTap: () => setState(() {
                                _choice = 'T';
                              }),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            ListTile(
                              tileColor: scaffoldColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                side: BorderSide(
                                  color: primaryColor,
                                  width: 1.4,
                                ),
                              ),
                              selected: _choice == 'F',
                              title: const Text('False'),
                              onTap: () => setState(() {
                                _choice = 'F';
                              }),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (_pageController.page! > 0) {
                                    // If it is not the first page
                                    setState(() => index--);
                                    _pageController.jumpToPage(index--);
                                  }
                                },
                                child: Text(
                                  'Previous',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (_choice.toString() ==
                                      questions[index].answer) {
                                    Provider.of<ScoreProvider>(context,
                                            listen: false)
                                        .incrementScore(1);
                                  }
                                  if (_pageController.page !=
                                      questions.length - 1) {
                                    // If it is not the last page
                                    setState(() => index++);
                                    _pageController.jumpToPage(index++);
                                  } else {
                                    Navigator.of(context).pushNamed(
                                      '/finalScore',
                                    );
                                  }
                                },
                                child: Text(
                                  'Next',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
