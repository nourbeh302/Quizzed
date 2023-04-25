import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/providers/course_provider.dart';

class SingleCourseScreen extends StatelessWidget {
  static const routeName = '/course';
  const SingleCourseScreen({super.key});

  String timestampToDateTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    final formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final courseId = ModalRoute.of(context)!.settings.arguments as String;
    final courseProvider = Provider.of<CourseProvider>(context);

    return StreamBuilder<List<Course>>(
      stream: courseProvider.coursesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final courses = snapshot.data ?? [];
        courseProvider.setCourses(courses);

        final Course course = courseProvider.getSingleCourse(courseId);

        return Scaffold(
          appBar: AppBar(
            title: Text(course.name),
          ),
          body: Column(
            children: [
              Image.network(course.imageUrl),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Created at: ${timestampToDateTime(course.createdAt)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    OutlinedButton(
                      onPressed: null,
                      child: Text(
                        'View quizzes',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
