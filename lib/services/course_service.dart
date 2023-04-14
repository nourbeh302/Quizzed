import 'package:cloud_firestore/cloud_firestore.dart';

class CourseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addCourse(String name, String image) async {
    await _firebaseFirestore
        .collection('Courses')
        .add({'name': name, 'image': image});
  }
}
