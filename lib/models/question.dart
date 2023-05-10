import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  String id = '';
  late final String body;
  String answer;
  DocumentReference? quizRef;

  Question(this.body, this.answer);

  factory Question.fromDocument(DocumentSnapshot doc, String quizId) {
    final data = doc.data() as Map<String, dynamic>;

    return Question(
      data['body'],
      data['answer'],
    );
  }
}
