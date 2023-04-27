import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/providers/course_provider.dart';
// import 'package:quizzed/providers/quiz_provider.dart';

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
    // final quizProvider = Provider.of<QuizProvider>(context);

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
        // var availableQuizzes = quizProvider.getQuizzes(courseId);

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
                      height: 24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: null,
                            child: Text(
                              'View quizzes',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                      ],
                    )
                    // StreamBuilder(
                    //     stream: availableQuizzes,
                    //     builder: (context, snapshot) {
                    //       final quizzes = snapshot.data ?? [];
                    //       quizProvider.setquizzes(quizzes);

                    //       // return quizzes.isNotEmpty
                    //       //     ? ListView.builder(
                    //       //         itemCount: quizzes.length,
                    //       //         itemBuilder:
                    //       //             (BuildContext context, int index) {
                    //       //           return ListTile(
                    //       //               title: Text("List item $index"));
                    //       //         })
                    //       //     : const Text('No quizzes yet.');
                    //       return ListView.builder(
                    //           itemCount: quizzes.length,
                    //           itemBuilder: (BuildContext context, int index) {
                    //             return ListTile(
                    //                 title: Text("List item ${quizzes[0]}"));
                    //           });
                    //     })
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
