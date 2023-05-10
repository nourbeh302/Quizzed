import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/student_score.dart';

class ScoreProvider with ChangeNotifier {
  final _scoresCollection =
      FirebaseFirestore.instance.collection('Student_Scores');
  final _usersCollection = FirebaseFirestore.instance.collection('Users');
  final _quizzesCollection = FirebaseFirestore.instance.collection('Quizzes');

  int _score = 0;
  int get score => _score;

  set score(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  void incrementScore() {
    _score++;
    notifyListeners();
  }

  Stream<int> getRemainingTime(durationInSeconds) {
    return Stream.periodic(const Duration(seconds: 1), (int i) => i)
        .take(durationInSeconds);
  }

  Stream<List<StudentScore>> getFinalScore(String userId, String quizId) {
    var snapshots = _scoresCollection.snapshots();
    var scoreStream = snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        StudentScore newStudentScore = StudentScore(
          doc.data()['title'],
        );
        newStudentScore.id = doc.id;
        newStudentScore.userRef = _usersCollection.doc(userId);
        newStudentScore.quizRef = _quizzesCollection.doc(quizId);
        return newStudentScore;
      }).toList();
    });
    return scoreStream;
  }

  Future<void> addFinalScore(
      StudentScore studentScore, String userId, String quizId) async {
    final scoreDoc = _scoresCollection.doc();
    await scoreDoc.set({
      'userRef': _usersCollection.doc(userId),
      'quizRef': _quizzesCollection.doc(quizId),
      'finalScore': studentScore.finalScore,
    });
    studentScore.id = scoreDoc.id;
    notifyListeners();
  }
}
