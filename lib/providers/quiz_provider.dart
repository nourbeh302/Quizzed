import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/quiz.dart';

class QuizProvider extends ChangeNotifier {
  final _quizzesCollection = FirebaseFirestore.instance.collection('Quizzes');

  List<Quiz> _quizzes = [];
  List<Quiz> get quizzes => _quizzes;

  Stream<List<Quiz>> getAllQuizzes(String courseId) {
    var snapshots = _quizzesCollection.snapshots();
    var quizStream = snapshots.map((snapshot) {
      return snapshot.docs
          .where((doc) =>
              doc.reference.collection('/Courses').doc(courseId) != null)
          .map((doc) {
        Quiz newQuiz = Quiz.fromDocument(doc, courseId);
        newQuiz.cuid = doc.reference.collection('/Courses').doc(courseId);
        return newQuiz;
      }).toList();
    });
    return quizStream;
  }

  void setQuizzes(List<Quiz> quizzes) {
    _quizzes = quizzes;
    notifyListeners();
  }
}
