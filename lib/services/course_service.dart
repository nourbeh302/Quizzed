import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzed/models/course.dart';

class CourseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionName = 'Courses';

  Future<List<Course>?> getCourses() async {
    try {
      final snapshot =
          await _firebaseFirestore.collection(_collectionName).get();
      final courses = snapshot.docs
          .map((doc) => Course(doc.data()['name'], doc.data()['image']))
          .toList();
      return courses;
    } catch (e) {
      return null;
    }
  }

  Future<void> addCourse(String name, String image) async {
    await _firebaseFirestore
        .collection(_collectionName)
        .add({'name': name, 'image': image});
  }
}
