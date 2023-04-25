import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String cuid;
  final String name;
  final String imageUrl;
  final Timestamp createdAt;

  Course({
    required this.cuid,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
  });
}