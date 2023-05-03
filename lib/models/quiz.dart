import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String quid = '';
  String title;
  Timestamp createdAt;
  int duration;
  int questionCount;
  DocumentReference? cuid;

  Quiz(
    this.title,
    this.createdAt,
    this.duration,
    this.questionCount,
  );

  factory Quiz.fromDocument(DocumentSnapshot doc, String courseId) {
    final data = doc.data() as Map<String, dynamic>;

    return Quiz(
      data['title'],
      data['createdAt'],
      data['duration'],
      data['questionCount'],
    );
  }
}
