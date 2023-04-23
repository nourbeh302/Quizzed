import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizzed/models/course.dart';

class CourseProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Reference _ref =
      FirebaseStorage.instanceFor(bucket: 'gs://quizzed-69c4e.appspot.com')
          .ref();
  final List<Course> _courses = [];

  List<Course> get courses => _courses;

  Stream<List<Course>> getAllCourses() {
    return _db.collection('Courses').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Course.fromSnapshot(doc)).toList());
  }

  Future<void> addCourse(Course course) async {
    try {
      await _db.collection('Courses').add({
        'name': course.name,
        'imageUrl': course.imageUrl,
        'createdAt': course.createdAt
      });
      notifyListeners();
    } catch (error) {
      return;
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

    notifyListeners();
    return File(image!.path);
  }

  Future<String> uploadImage(File pickedImage) async {
    final String bucket = 'media/${pickedImage.path.split('/').last}';
    final File image = File(pickedImage.path);
    final Task uploadTask = _ref.child(bucket).putFile(image);

    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    notifyListeners();
    return urlDownload;
  }
}
