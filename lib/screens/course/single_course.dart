import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/models/quiz.dart';
import 'package:quizzed/providers/course_provider.dart';
import 'package:quizzed/providers/quiz_provider.dart';

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
    final quizProvider = Provider.of<QuizProvider>(context);

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
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Quiz>>(
              stream: quizProvider.getAllQuizzes(courseId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                        'Sorry, there are currently no quizzes available at this time. Please check back later or contact your instructor for more information.'),
                  );
                }

                final quizzes = snapshot.data!;
                quizProvider.setQuizzes(quizzes, courseId);

                return ListView.separated(
                  itemCount: quizzes.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox.shrink(),
                  itemBuilder: (BuildContext context, int index) {
                    final quiz = quizzes[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: null,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                quiz.title,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Text(timestampToDateTime(quiz.createdAt)),
                              Text('${quiz.duration} min(s)'),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: OutlinedButton(
                                      onPressed: null,
                                      child: Text('Learn More',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                    ),
                                  ),
                                  const Expanded(
                                      flex: 1,
                                      child: SizedBox.shrink()), // Empty row slot
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
