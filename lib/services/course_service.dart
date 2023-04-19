import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizzed/models/course.dart';

class CourseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _collectionName = 'Courses';
  final Reference _ref =
        FirebaseStorage.instanceFor(bucket: 'gs://quizzed-69c4e.appspot.com')
            .ref();

  Stream<QuerySnapshot> getCourses() =>
      _firebaseFirestore.collection(_collectionName).snapshots();

  Future<void> addCourse(Course course) async {
    await _firebaseFirestore.collection(_collectionName).add({
      'name': course.name,
      'image': course.image,
      'createdAt': course.createdAt
    });
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
    final Task uploadTask = _ref.child(bucket).putFile(image);

    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }
}
