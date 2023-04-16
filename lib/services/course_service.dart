import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzed/models/course.dart';

class CourseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionName = 'Courses';

  Stream<QuerySnapshot> getCourses() =>
      _firebaseFirestore.collection(_collectionName).snapshots();

  Future<void> addCourse(Course course) async {
    await _firebaseFirestore.collection(_collectionName).add({
      'name': course.name,
      'image': course.image,
      'createdAt': course.createdAt
    });
  }
}
