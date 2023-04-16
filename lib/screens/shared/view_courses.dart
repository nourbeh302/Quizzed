import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/services/course_service.dart';
import 'package:quizzed/widgets/appbar.dart';
import 'package:quizzed/widgets/circular_progress.dart';
import 'package:quizzed/widgets/course_card.dart';

class ViewCoursesScreen extends StatefulWidget {
  const ViewCoursesScreen({super.key});

  @override
  State<ViewCoursesScreen> createState() => _ViewCoursesScreenState();
}

class _ViewCoursesScreenState extends State<ViewCoursesScreen> {
  CourseService courseService = CourseService();

  dynamic getCourses() => courseService.getCourses();

  Course convertDocumentSnapshotToCourse(
      QueryDocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Course(data['name'], data['image'], data['createdAt']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzedAppBar(title: 'Courses', isBackButtonActive: true),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: getCourses(),
            builder: (context, snapshot) {
              List<Widget> courseList = [];
              if (snapshot.hasData) {
                final courses = snapshot.data?.docs.toList();
                for (var course in courses!) {
                  var singleCourse = CourseCard(
                      course: convertDocumentSnapshotToCourse(course));
                  courseList.add(singleCourse);
                }
                return courses.isNotEmpty
                    ? ListView(children: courseList)
                    : const Text('No courses were found. Try adding some');
              } else {
                return const CircularProgress();
              }
            }),
      ),
    );
  }
}
