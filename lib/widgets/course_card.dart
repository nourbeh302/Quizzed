import 'package:flutter/material.dart';
import 'package:quizzed/helpers/format_date.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/providers/auth_provider.dart';
import 'package:quizzed/providers/course_provider.dart';

class CourseCard extends StatefulWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  final formatter = TimestampFormatter();

  CourseProvider courseProvider = CourseProvider();
  AuthProvider authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.course.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.course.name,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                      'Upload date: ${formatter.formatTimestamp(widget.course.createdAt)}'),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, '/course',
                              arguments: widget.course.cuid),
                          child: Text('View',
                              style: Theme.of(context).textTheme.labelMedium),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      FutureBuilder(
                          future: authProvider.getFireStoreUser(),
                          builder: (context, snapshot) {
                            var user = snapshot.data;
                            if (user!.isProfessor) {
                              return Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () {
                                    courseProvider
                                        .deleteCourse(widget.course.cuid);
                                    Navigator.pop(context, '/');
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        StadiumBorder>(
                                      const StadiumBorder(
                                        side: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Expanded(
                                flex: 1,
                                child: SizedBox.shrink(),
                              );
                            }
                          })
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
