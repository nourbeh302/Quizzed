import 'package:flutter/material.dart';
import 'package:quizzed/helpers/format_date.dart';
import 'package:quizzed/models/course.dart';

class CourseCard extends StatefulWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  final formatter = TimestampFormatter();

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
                    formatter.formatTimestamp(widget.course.createdAt),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pushNamed(context, '/course', arguments: widget.course.cuid),
                          child: Text('View course',
                              style: Theme.of(context).textTheme.labelMedium),
                        ),
                      ),
                      const Expanded(
                          flex: 1, child: SizedBox.shrink()), // Empty row slot
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
