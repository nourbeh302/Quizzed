import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/providers/course_provider.dart';
import 'package:quizzed/widgets/course_card.dart';

class ViewCoursesScreen extends StatelessWidget {
  const ViewCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder<List<Course>>(
        stream: courseProvider.coursesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final courses = snapshot.data ?? [];
          courseProvider.setCourses(courses);

          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      spreadRadius: 0.5,
                      blurRadius: 2,
                      color: Color.fromRGBO(116, 116, 116, 0.473),
                    )
                  ],
                ),
                margin: const EdgeInsets.all(24.0),
                child: CourseCard(course: course),
              );
            },
          );
        },
      ),
    );
  }
}
