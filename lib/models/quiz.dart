import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String quid = '';
  final String title;
  final Timestamp createdAt;
  final String duration;
  final String cuid;

  Quiz(this.title, this.createdAt, this.duration, this.cuid);
}
