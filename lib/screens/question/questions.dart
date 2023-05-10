import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/constant.dart';
import 'package:quizzed/models/question.dart';
import 'package:quizzed/models/quiz.dart';
import 'package:quizzed/models/student_score.dart';
import 'package:quizzed/providers/auth_provider.dart';
import 'package:quizzed/providers/question_provider.dart';
import 'package:quizzed/providers/quiz_provider.dart';
import 'package:quizzed/providers/score_provider.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  String _choice = '';
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);
    scoreProvider.score = 0; // Reset score
  }

  @override
  Widget build(BuildContext context) {
    Quiz quiz = ModalRoute.of(context)!.settings.arguments as Quiz;

    QuizProvider quizProvider = QuizProvider();
    QuestionProvider questionProvider = QuestionProvider();
    final scoreProvider = Provider.of<ScoreProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context);

    int durationInSeconds = quiz.duration * 60;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Questions'),
            StreamBuilder<int>(
              stream: scoreProvider.getRemainingTime(durationInSeconds),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int secondsRemaining = durationInSeconds - snapshot.data!;
                  int minutes = secondsRemaining ~/ 60;
                  int remainingSeconds = secondsRemaining % 60;
                  String formattedTime =
                      '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
                  return Text(
                    formattedTime,
                  );
                } else {
                  // Navigator.pushNamed(
                  //   context,
                  //   '/finalScore',
                  //   arguments: [0, 0],
                  // );
                  return const Text(
                    '00:00',
                  );
                }
              },
            ),
          ],
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<String?>(
        future: quizProvider.getQuizIdByTitle(quiz.title),
        builder: (context, snapshot) {
          var quizId = snapshot.data ?? '';

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
                        Column(
                          children: [
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_choice.toString() ==
                                          questions[index].answer) {
                                        // If answer is correct
                                        scoreProvider.incrementScore();
                                      }
                                      if (_pageController.page !=
                                          questions.length - 1) {
                                        // If it is not the last page
                                        setState(() => index++);
                                        _pageController.jumpToPage(index++);
                                      } else {
                                        scoreProvider.addFinalScore(
                                          StudentScore(scoreProvider.score),
                                          authProvider.loggedInUser!.uid,
                                          quizId,
                                        );
                                        Navigator.of(context).pushNamed(
                                          '/finalScore',
                                          arguments: [
                                            scoreProvider.score,
                                            questions.length
                                          ],
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Next',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            OutlinedButton(
                              onPressed: null,
                              child: Text(
                                'Leave Quiz',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
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
