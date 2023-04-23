import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String cuid = '';
  String name;
  String imageUrl;
  Timestamp createdAt;

  Course(this.name, this.imageUrl, this.createdAt);

  factory Course.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Course(data['name'], data['imageUrl'], data['createdAt']);
  }
}
