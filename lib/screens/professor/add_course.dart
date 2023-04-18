import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

import 'package:quizzed/constant.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/validators/name_validator.dart';
import 'package:quizzed/widgets/appbar.dart';
import 'package:quizzed/services/course_service.dart';

// final _formKey = GlobalKey<FormState>(debugLabel: const Uuid().v4());
final _formKey = Key(const Uuid().v4());

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
  PlatformFile? pickedImage;
  late String downloadUrl;

  // Define service
  final CourseService _courseService = CourseService();

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

  Future selectFile() async {
    final result = await _courseService.selectImage();
    setState(() => pickedImage = result);
  }

  Future<void> uploadImage(pickedImage) async {
    downloadUrl = await _courseService.uploadImage(pickedImage);
    Course course = Course(_nameController.text, downloadUrl, Timestamp.now());
    _courseService.addCourse(course);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: uploadImage(pickedImage),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: const QuizzedAppBar(
              title: "Add Course",
              isBackButtonActive: true,
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
                                child: Image.file(
                                  File(pickedImage!.path!),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      OutlinedButton(
                        onPressed: () => selectFile(),
                        child: Text('Select Image',
                            style: Theme.of(context).textTheme.labelMedium),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          uploadImage(pickedImage);
                          Navigator.pushNamed(context, '/');
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
        });
  }
}
