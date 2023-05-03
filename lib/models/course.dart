import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String cuid = '';
  final String name;
  final String imageUrl;
  final Timestamp createdAt;

  Course(this.name, this.imageUrl, this.createdAt);
}
