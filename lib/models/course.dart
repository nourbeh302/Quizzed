import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String cuid = '';
  String name;
  String image;
  Timestamp createdAt;

  Course(this.name, this.image, this.createdAt);
}