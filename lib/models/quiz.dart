import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String quid;
  String title;
  Timestamp createdAt;
  String duration;
  DocumentReference? cuid;

  Quiz(
    this.quid,
    this.title,
    this.createdAt,
    this.duration,
  );

  factory Quiz.fromDocument(DocumentSnapshot doc, String courseId) {
    final data = doc.data() as Map<String, dynamic>;

    return Quiz(
      doc.id,
      data['title'],
      data['createdAt'],
      data['duration'],
    );
  }
}
