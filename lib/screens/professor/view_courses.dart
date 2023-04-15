import 'package:flutter/material.dart';
import 'package:quizzed/models/course.dart';
import 'package:quizzed/services/course_service.dart';
import 'package:quizzed/widgets/appbar.dart';
import 'package:quizzed/widgets/circular_progress.dart';
// import 'package:quizzed/widgets/navbar.dart';

class ViewCoursesScreen extends StatefulWidget {
  const ViewCoursesScreen({super.key});

  @override
  State<ViewCoursesScreen> createState() => _ViewCoursesScreenState();
}

class _ViewCoursesScreenState extends State<ViewCoursesScreen> {
  late Future<List<Course>> courses;
  CourseService courseService = CourseService();

  Future<List<Course>> getCourses() async {
    return courses = await Future.value(courseService.getCourses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizzedAppBar(title: 'Courses', isBackButtonActive: true),
      body: Center(
        child: FutureBuilder<List<Course>>(
          future: getCourses(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgress();
            if (snapshot.data!.isEmpty) return const Text('No courses were found. Try adding some');
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final course = snapshot.data![index];
                return ListTile(
                  title: Text(course.name),
                  subtitle: Text('Created at: ${course.createdAt.hour}:${course.createdAt.minute} ${course.createdAt.day}/${course.createdAt.month}/${course.createdAt.year}'),
                );
              },
            );
          },
        ),
      ),
      // bottomNavigationBar: const QuizzedNavbar(),
    );
  }
}
