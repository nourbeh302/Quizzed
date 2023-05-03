import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String quid = '';
  String title;
  Timestamp createdAt;
  int duration;
  DocumentReference? cuid;

  Quiz(
    this.title,
    this.createdAt,
    this.duration,
  );

  factory Quiz.fromDocument(DocumentSnapshot doc, String courseId) {
    final data = doc.data() as Map<String, dynamic>;

    return Quiz(
      data['title'],
      data['createdAt'],
      data['duration'],
    );
  }
}
