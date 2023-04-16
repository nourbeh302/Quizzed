import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzed/models/course.dart';

class CourseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionName = 'Courses';

  Future<List<Course>> getCourses() async {
    try {
      final snapshot =
          await _firebaseFirestore.collection(_collectionName).get();
      final courses = snapshot.docs
          .map((doc) => Course(
              doc.data()['name'], doc.data()['image'], doc.data()['createdAt']))
          .toList();
      return courses;
    } catch (e) {
      throw Error();
    }
  }

  Future<void> addCourse(Course course) async {
    await _firebaseFirestore.collection(_collectionName).add({
      'name': course.name,
      'image': course.image,
      'createdAt': course.createdAt
    });
  }
}
