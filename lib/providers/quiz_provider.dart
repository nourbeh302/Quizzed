import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/quiz.dart';

class QuizProvider extends ChangeNotifier {
  final _quizzesCollection = FirebaseFirestore.instance.collection('Quizzes');
  final _coursesCollection = FirebaseFirestore.instance.collection('Courses');

  List<Quiz> _quizzes = [];
  List<Quiz> get quizzes => _quizzes;

  Stream<List<Quiz>> getAllQuizzes() {
    var snapshots = _quizzesCollection.snapshots();
    var quizStream = snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        Quiz newQuiz = Quiz(
          doc.data()['title'],
          doc.data()['createdAt'],
          doc.data()['duration'],
          doc.data()['questionCount'],
        );
        return newQuiz;
      }).toList();
    });
    return quizStream;
  }

  Stream<List<Quiz>> getQuizzesByCourseId(String courseId) {
    var snapshots = _quizzesCollection
        .where('courseRef', isEqualTo: _coursesCollection.doc(courseId))
        .snapshots();
    var quizStream = snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        Quiz newQuiz = Quiz.fromDocument(doc, courseId);
        newQuiz.courseRef = _coursesCollection.doc(courseId);
        return newQuiz;
      }).toList();
    });
    return quizStream;
  }

  void setQuizzes(List<Quiz> quizzes) {
    _quizzes = quizzes
      ..sort((quiz1, quiz2) => quiz1.createdAt.compareTo(quiz2.createdAt));
    notifyListeners();
  }

  Future<void> addQuiz(Quiz quiz, String courseId) async {
    final quizDoc = _quizzesCollection.doc();
    await quizDoc.set({
      'title': quiz.title,
      'createdAt': quiz.createdAt,
      'duration': quiz.duration,
      'questionCount': quiz.questionCount,
      'courseRef': quiz.courseRef,
    });
    quiz.quid = quizDoc.id;
    notifyListeners();
  }
}
