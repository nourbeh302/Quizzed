import 'package:flutter/material.dart';
import 'package:quizzed/constant.dart';
import 'package:quizzed/models/question.dart';
import 'package:quizzed/models/quiz.dart';
import 'package:quizzed/providers/question_provider.dart';
import 'package:quizzed/providers/quiz_provider.dart';

class AddQuestionsScreen extends StatefulWidget {
  const AddQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<AddQuestionsScreen> createState() => _AddQuestionsScreenState();
}

class _AddQuestionsScreenState extends State<AddQuestionsScreen> {
  late List<TextEditingController> questiontextControllers;
  late List<TextEditingController> answertextControllers;

  // Define provider
  final quizProvider = QuizProvider();
  final questionProvider = QuestionProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ModalRoute.of(context)!.settings.arguments as Quiz;
    questiontextControllers = List.generate(
      quiz.questionCount,
      (_) => TextEditingController(),
    );
    answertextControllers = List.generate(
      quiz.questionCount,
      (_) => TextEditingController(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.title),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: quiz.questionCount,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: questiontextControllers[index],
                        style: TextStyle(
                          fontFamily: baseFontFamily,
                          fontSize: inputFontSize,
                        ),
                        decoration: InputDecoration(
                          hintText: "Question Body ${index + 1}",
                          hintStyle: TextStyle(
                            fontFamily: baseFontFamily,
                            fontSize: inputFontSize,
                          ),
                          focusColor: primaryColor,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox.shrink(),
                      TextFormField(
                        controller: answertextControllers[index],
                        style: TextStyle(
                          fontFamily: baseFontFamily,
                          fontSize: inputFontSize,
                        ),
                        decoration: InputDecoration(
                          hintText: "Answer #${index + 1}",
                          hintStyle: TextStyle(
                            fontFamily: baseFontFamily,
                            fontSize: inputFontSize,
                          ),
                          focusColor: primaryColor,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            // Text(quiz.cuid!.path),
            ElevatedButton(
              onPressed: () {
                // Add quiz
                // Add question
                for (var i = 0; i < quiz.questionCount; i++) {
                  quizProvider.addQuiz(
                    Quiz(
                      quiz.title,
                      quiz.createdAt,
                      quiz.duration,
                      quiz.questionCount,
                    ),
                    quiz.cuid!.path,
                  );

                  print("================${quiz.title.toString()}================");
                  print("================${quiz.createdAt.toString()}================");
                  print("================${quiz.duration.toString()}================");
                  print("================${quiz.questionCount.toString()}================");
                  print("================${quiz.quid.toString()}================");

                  questionProvider.addQuestion(
                    Question(
                      questiontextControllers[i].text,
                      answertextControllers[i].text,
                    ),
                    quiz.quid,
                  );
                }

                Navigator.pop(context);
              },
              child: Text('Add Quiz',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ],
        ),
      ),
    );
  }
}
