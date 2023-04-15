import 'package:flutter/material.dart';
import 'package:quizzed/constant.dart';
import 'package:quizzed/validators/name_validator.dart';
import 'package:quizzed/widgets/appbar.dart';
import 'package:quizzed/services/course_service.dart';
import 'package:quizzed/widgets/navbar.dart';

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
  final _imageValidator = NameValidator(); // Needs enhancement

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzedAppBar(
        title: "Add Course",
        isBackButtonActive: true,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 48, 0, 0),
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
                        height: 32,
                      ),
                      TextFormField(
                        controller: _imageController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Fill the field";
                          }
                          if (!_imageValidator.isNameValid(value)) {
                            return "Images should be at least 3 characters";
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontFamily: baseFontFamily,
                            fontSize: inputFontSize),
                        decoration: InputDecoration(
                            hintText: "Image",
                            hintStyle: TextStyle(
                                fontFamily: baseFontFamily,
                                fontSize: inputFontSize),
                            focusColor: primaryColor,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: primaryColor,
                            ))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: Text(
                    'A newbie here? Create new account',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      _courseService.addCourse(
                          _nameController.text, _imageController.text);
                    }
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  child: Text('Add Course',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const QuizzedNavbar(),
    );
  }
}
