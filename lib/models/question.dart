import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String id = '';
  final String body;
  final String answerId;
  DocumentReference? quid;

  Question(this.body, this.answerId);

  factory Question.fromDocument(DocumentSnapshot doc, String quizId) {
    final data = doc.data() as Map<String, dynamic>;

    return Question(
      data['body'],
      data['answerId'],
    );
  }
}