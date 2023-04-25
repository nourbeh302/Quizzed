import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/course.dart';

class CourseProvider with ChangeNotifier {
  final _coursesCollection = FirebaseFirestore.instance.collection('Courses');

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  Stream<List<Course>> get coursesStream =>
      _coursesCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return Course(
            cuid: doc.id,
            name: data['name'],
            imageUrl: data['imageUrl'],
            createdAt: data['createdAt'],
          );
        }).toList();
      });

  void setCourses(List<Course> courses) {
    _courses = courses;
    notifyListeners();
  }

  Course getSingleCourse(String cuid) {
    return courses.firstWhere((course) => course.cuid == cuid);
  }

  Future<void> addCourse(Course course) async {
    try {
      final doc = await _coursesCollection.add({
        'name': course.name,
        'imageUrl': course.imageUrl,
        'createdAt': course.createdAt,
      });
      _courses.add(Course(
        cuid: doc.id,
        name: course.name,
        imageUrl: course.imageUrl,
        createdAt: course.createdAt,
      ));
      notifyListeners();
    } catch (error) {
      log('Failed to add course: $error');
    }
  }
}
