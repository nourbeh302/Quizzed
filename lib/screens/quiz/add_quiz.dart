import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:quizzed/constant.dart';
import 'package:quizzed/models/quiz.dart';
import 'package:quizzed/providers/quiz_provider.dart';
import 'package:quizzed/validators/string_validator.dart';

final _formKey = GlobalKey<FormState>();

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({super.key});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  // Define input controllers
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _titleValidator = StringValidator();

  // Define provider
  final quizProvider = QuizProvider();

  void showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          error,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    _titleController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Quiz'),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Fill the field";
                          }
                          if (!_titleValidator.isValueValid(value)) {
                            return "Course name should be at least 3 characters";
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontFamily: baseFontFamily,
                            fontSize: inputFontSize),
                        decoration: InputDecoration(
                          hintText: "Quiz Title",
                          hintStyle: TextStyle(
                              fontFamily: baseFontFamily,
                              fontSize: inputFontSize),
                          focusColor: primaryColor,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        controller: _durationController,
                        style: TextStyle(
                            fontFamily: baseFontFamily,
                            fontSize: inputFontSize),
                        decoration: InputDecoration(
                          hintText: "Duration in minutes",
                          hintStyle: TextStyle(
                              fontFamily: baseFontFamily,
                              fontSize: inputFontSize),
                          focusColor: primaryColor,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    quizProvider.addQuiz(
                      Quiz(_titleController.text, Timestamp.now(),
                          int.parse(_durationController.text)),
                      courseId,
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Add Quiz',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
