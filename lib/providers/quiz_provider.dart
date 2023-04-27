import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/quiz.dart';

class QuizProvider with ChangeNotifier {
  final _quizzesCollection = FirebaseFirestore.instance.collection('Quizzes');

  List<Quiz> _quizzes = [];
  List<Quiz> get quizzes => _quizzes;

  // Stream<List<Quiz>> get quizzesStream =>
  //     _quizzesCollection.snapshots().map((snapshot) {
  //       return snapshot.docs.map((doc) {
  //         final data = doc.data();
  //         Quiz newQuiz = Quiz(
  //           data['title'],
  //           data['createdAt'],
  //           data['duration'],
  //           data['cuid'],
  //         );
  //         return newQuiz;
  //       })
  //       .where((quiz) => quiz.cuid == '')
  //       .toList();
  //     });

  Stream<List<Quiz>> getQuizzes(String cuid) => _quizzesCollection
          .where('cuid', isEqualTo: cuid)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) {
              final data = doc.data();
              Quiz newQuiz = Quiz(
                data['title'],
                data['createdAt'],
                data['duration'],
                data['cuid'],
              );
              return newQuiz;
            })
            .toList();
      });

  void setquizzes(List<Quiz> quizzes) {
    _quizzes = quizzes;
    notifyListeners();
  }

  Quiz getSingleQuiz(String cuid) {
    return quizzes.firstWhere((quiz) => quiz.cuid == cuid);
  }

  Future<void> addQuiz(Quiz quiz, String courseId) async {
    try {
      var doc = await _quizzesCollection.add({
        'title': quiz.title,
        'createdAt': quiz.createdAt,
        'duration': quiz.duration,
        'cuid': courseId,
      });
      Quiz newQuiz = Quiz(
        quiz.title,
        quiz.createdAt,
        quiz.duration,
        courseId,
      );
      newQuiz.quid = doc.id;
      _quizzes.add(newQuiz);
      notifyListeners();
    } catch (error) {
      log('Failed to add Quiz: $error');
    }
  }
}
