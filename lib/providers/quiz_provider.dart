import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/quiz.dart';

class QuizProvider extends ChangeNotifier {
  final _quizzesCollection = FirebaseFirestore.instance.collection('Quizzes');
  final _coursesCollection = FirebaseFirestore.instance.collection('Courses');

  List<Quiz> _quizzes = [];
  List<Quiz> get quizzes => _quizzes;

  Stream<List<Quiz>> getAllQuizzes(String courseId) {
    var snapshots = _quizzesCollection
        .where('cuid', isEqualTo: _coursesCollection.doc(courseId))
        .snapshots();
    var quizStream = snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        Quiz newQuiz = Quiz.fromDocument(doc, courseId);
        newQuiz.cuid = _coursesCollection.doc(courseId);
        return newQuiz;
      }).toList();
    });
    return quizStream;
  }

  void setQuizzes(List<Quiz> quizzes, String courseId) {
    _quizzes = quizzes..sort((quiz1, quiz2) => quiz1.createdAt.compareTo(quiz2.createdAt));
    notifyListeners();
  }

  Future<void> addQuiz(Quiz quiz, String courseId) async {
    try {
      var doc = await _quizzesCollection.add({
        'title': quiz.title,
        'duration': quiz.duration,
        'createdAt': quiz.createdAt,
        'questionCount': quiz.questionCount,
        'cuid': _coursesCollection.doc(courseId),
      });
      Quiz newQuiz = Quiz(
        quiz.title,
        quiz.createdAt,
        quiz.duration,
        quiz.questionCount,
      );
      newQuiz.quid = doc.id;
      newQuiz.cuid = _coursesCollection.doc(courseId);
      _quizzes.add(newQuiz);
      notifyListeners();
    } catch (error) {
      log('Failed to add course: $error');
    }
  }
}
