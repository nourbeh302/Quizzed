import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String id = '';
  late final String body;
  String answerId;
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
