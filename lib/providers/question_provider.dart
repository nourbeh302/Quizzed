import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/question.dart';

class QuestionProvider extends ChangeNotifier {
  final _questionsCollection = FirebaseFirestore.instance.collection('Questions');
  final _quizzesCollection = FirebaseFirestore.instance.collection('Quizzes');

  List<Question> _questions = [];
  List<Question> get questions => _questions;

  Stream<List<Question>> getAllQuestions(String quizId) {
    var snapshots = _questionsCollection
        .where('quizRef', isEqualTo: _quizzesCollection.doc(quizId))
        .snapshots();
    var questionStream = snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        Question newQuestion = Question.fromDocument(doc, quizId);
        newQuestion.quizRef = _quizzesCollection.doc(quizId);
        return newQuestion;
      }).toList();
    });
    return questionStream;
  }

  void setQuestions(List<Question> questions) {
    _questions = questions;
    notifyListeners();
  }

  Future<void> addQuestion(Question question, String quizId) async {
    try {
      var doc = await _questionsCollection.add({
        'body': question.body,
        'answer': question.answer,
        'quizRef': _quizzesCollection.doc(quizId),
      });
      Question newQuestion = Question(
        question.body,
        question.answer,
      );
      newQuestion.id = doc.id;
      newQuestion.quizRef = _quizzesCollection.doc(quizId);
      _questions.add(newQuestion);
      notifyListeners();
    } catch (error) {
      log('Failed to add course: $error');
    }
  }
}
