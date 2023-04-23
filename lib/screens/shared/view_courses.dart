// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/providers/course_provider.dart';
import 'package:quizzed/widgets/circular_progress.dart';
import 'package:quizzed/widgets/course_card.dart';

class ViewCoursesScreen extends StatelessWidget {
  const ViewCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<CourseProvider>(context).getAllCourses();

    return StreamBuilder<List<Course>>(
      stream: courses,
      builder: (context, snapshot) {
        List<Widget> coursesColumn = [];
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Courses'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Courses'),
            ),
            body: const Center(
              child: CircularProgress(),
            ),
          );
        }

        final courses = snapshot.data!;
        for (var course in courses) {
          var singleCourse = CourseCard(course: course);
          coursesColumn.add(singleCourse);
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Courses'),
          ),
          body: courses.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    itemCount: coursesColumn.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 24.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return coursesColumn[index];
                    },
                  ),
                )
              : const Center(
                  child: Text('No courses are available now'),
                ),
        );
      },
    );
  }
}
