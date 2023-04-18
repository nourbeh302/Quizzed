import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quizzed/models/course.dart';

class CourseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionName = 'Courses';
  PlatformFile? pickedFile;

  Stream<QuerySnapshot> getCourses() =>
      _firebaseFirestore.collection(_collectionName).snapshots();

  Future<void> addCourse(Course course) async {
    await _firebaseFirestore.collection(_collectionName).add({
      'name': course.name,
      'image': course.image,
      'createdAt': course.createdAt
    });
  }

  Future<PlatformFile?> selectImage() async {
    final result = await FilePicker.platform.pickFiles();

    return result?.files.first;
  }

  Future<String> uploadImage(PlatformFile? pickedImage) async {
    final path = 'media/${pickedImage!.name}';
    final image = File(pickedImage.path!);

    final ref =
        FirebaseStorage.instanceFor(bucket: 'gs://quizzed-69c4e.appspot.com')
            .ref()
            .child(path);
    Task uploadTask = ref.putFile(image);

    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }
}
