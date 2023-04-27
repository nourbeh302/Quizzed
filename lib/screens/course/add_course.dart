import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:quizzed/constant.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/providers/course_provider.dart';
import 'package:quizzed/validators/name_validator.dart';

final _formKey = GlobalKey<FormState>();

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  // Define input controllers
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _nameValidator = NameValidator();

  // Define image file
  File? pickedImage;

  // Define provider
  final courseProvider = CourseProvider();

  void showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          error,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree
    _nameController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> selectImageFromGallery() async {
    final result = await courseProvider.selectImageFromGallery();
    setState(() => pickedImage = result);
  }

  Future<void> selectImageFromCameraRoll() async {
    final result = await courseProvider.selectImageFromCameraRoll();
    setState(() => pickedImage = result);
  }

  Future<void> uploadImage(pickedImage) async {
    String downloadUrl = await courseProvider.uploadImage(pickedImage);
    Course course = Course(
        name: _nameController.text,
        imageUrl: downloadUrl,
        createdAt: Timestamp.now());
    courseProvider.addCourse(course);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Course'),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Fill the field";
                          }
                          if (!_nameValidator.isNameValid(value)) {
                            return "Course name should be at least 3 characters";
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontFamily: baseFontFamily,
                            fontSize: inputFontSize),
                        decoration: InputDecoration(
                            hintText: "Course Name",
                            hintStyle: TextStyle(
                                fontFamily: baseFontFamily,
                                fontSize: inputFontSize),
                            focusColor: primaryColor,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: primaryColor,
                            ))),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      if (pickedImage != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          child: Image.file(File(pickedImage!.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () => selectImageFromGallery(),
                        child: Text('Gallery',
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () => selectImageFromCameraRoll(),
                        child: Text('Camera Roll',
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                    ), // Empty row slot
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      uploadImage(pickedImage);
                      Navigator.pushNamed(context, '/');
                    }
                  },
                  child: Text('Add Course',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
