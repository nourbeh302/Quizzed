import 'package:flutter/material.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/services/course_service.dart';

class ViewCoursesScreen extends StatefulWidget {
  const ViewCoursesScreen({super.key});

  @override
  State<ViewCoursesScreen> createState() => _ViewCoursesScreenState();
}

class _ViewCoursesScreenState extends State<ViewCoursesScreen> {
  final CourseService _courseService = CourseService();

  @override
  Widget build(BuildContext context) {
    final courses = Future.value(_courseService.getCourses());

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(courses.toString()),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/addCourse'),
              child: Text('Add new course',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ],
        ),
      ),
    ));
  }
}
