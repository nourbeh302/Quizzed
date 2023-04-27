import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizzed/models/course.dart';

class CourseProvider with ChangeNotifier {
  final _coursesCollection = FirebaseFirestore.instance.collection('Courses');
  final Reference _bucketRef =
      FirebaseStorage.instanceFor(bucket: 'gs://quizzed-69c4e.appspot.com')
          .ref();

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  Stream<List<Course>> get coursesStream =>
      _coursesCollection.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          Course newCourse = Course(
            name: data['name'],
            imageUrl: data['imageUrl'],
            createdAt: data['createdAt'],
          );
          newCourse.cuid = doc.id;
          return newCourse;
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
      var doc = await _coursesCollection.add({
        'name': course.name,
        'imageUrl': course.imageUrl,
        'createdAt': course.createdAt,
      });
      Course newCourse = Course(
        name: course.name,
        imageUrl: course.imageUrl,
        createdAt: course.createdAt,
      );
      newCourse.cuid = doc.id;
      _courses.add(newCourse);
      notifyListeners();
    } catch (error) {
      log('Failed to add course: $error');
    }
  }

  Future<File?> selectImageFromCameraRoll() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    return File(image!.path);
  }

  Future<File?> selectImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    return File(image!.path);
  }

  Future<String> uploadImage(File? pickedImage) async {
    final String bucket = 'media/${pickedImage!.path}';
    final File image = File(pickedImage.path);
    final Task uploadTask = _bucketRef.child(bucket).putFile(image);

    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }
}
