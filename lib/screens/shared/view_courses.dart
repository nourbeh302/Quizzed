import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<Course>> getCourses() async =>
      courses = await Future.value(courseService.getCourses());

  String convertDateToText(Timestamp timestamp) {
    var date = timestamp.toDate();
    var day = date.day < 10 ? '0${date.day}' : date.day;
    var month = date.month < 10 ? '0${date.month}' : date.month;
    var year = date.year;
    var hour = date.hour < 10 ? '0${date.hour}' : date.hour;
    var minute = date.minute < 10 ? '0${date.minute}' : date.minute;
    var morningOrNight = date.hour > 12 ? 'PM' : 'AM';

    return '$day/$month/$year $hour:$minute $morningOrNight';
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
            if (snapshot.data!.isEmpty) {
              return const Text('No courses were found. Try adding some');
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final course = snapshot.data![index];
                return ListTile(
                  title: Text(course.name,
                      style: Theme.of(context).textTheme.labelLarge),
                  subtitle:
                      Text('Created at: ${convertDateToText(course.createdAt)}'),
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
