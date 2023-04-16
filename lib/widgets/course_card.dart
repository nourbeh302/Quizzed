
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzed/models/course.dart';

class CourseCard extends StatefulWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.course.name),
          Text(convertDateToText(widget.course.createdAt))
        ],
      ),
    );
  }
}
