import 'package:cloud_firestore/cloud_firestore.dart';

class StudentScore {
  String id = '';
  DocumentReference? userRef;
  DocumentReference? quizRef;
  final int finalScore;

  StudentScore(this.finalScore);

  factory StudentScore.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    var studentScore = StudentScore(data['finalScore']);
    return studentScore;
  }
}
