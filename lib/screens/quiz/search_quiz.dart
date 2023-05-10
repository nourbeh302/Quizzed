import 'package:flutter/material.dart';
import 'package:quizzed/helpers/format_date.dart';
import 'package:quizzed/models/quiz.dart';
import 'package:quizzed/providers/quiz_provider.dart';

class SearchQuizScreen extends StatefulWidget {
  const SearchQuizScreen({super.key});

  @override
  State<SearchQuizScreen> createState() => _SearchQuizScreenState();
}

class _SearchQuizScreenState extends State<SearchQuizScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimestampFormatter formatter = TimestampFormatter();

  final QuizProvider _quizProvider = QuizProvider();
  List<Quiz> _quizzes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search quiz by date'),
        elevation: 0,
      ),
      body: StreamBuilder<List<Quiz>>(
        stream: _quizProvider.getAllQuizzes(),
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

          _quizzes = snapshot.data!;
          _quizProvider.setQuizzes(_quizzes);
          // _quizzes = filterQuizzes(_quizzes, _selectedTime);

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime,
                        );
                        if (selectedTime != null) {
                          final filteredQuizzes =
                              filterQuizzes(_quizzes, selectedTime);
                          setState(() {
                            _selectedTime = selectedTime;
                            _quizzes = filteredQuizzes;
                          });
                        }
                      },
                      child: Text(
                        'Choose Date',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      'Chosen time: ${_selectedTime.hour}:${_selectedTime.minute}',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _quizzes.length,
                  separatorBuilder: (context, index) => const SizedBox.shrink(),
                  itemBuilder: (BuildContext context, int index) {
                    final quiz = _quizzes[index];
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
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(formatter.formatTimestamp(quiz.createdAt)),
                              Text('Duration: ${quiz.duration} min(s)'),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: OutlinedButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        '/startQuiz',
                                        arguments: quiz,
                                      ),
                                      child: Text(
                                        'Learn More',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox.shrink(),
                                  ), // Empty row slot
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }

  List<Quiz> filterQuizzes(List<Quiz> quizzes, TimeOfDay selectedTime) {
    TimestampFormatter formatter = TimestampFormatter();

    return quizzes.where((quiz) {
      String formatterDateStringfied =
          formatter.formatTimestamp(quiz.createdAt);
      String selectedTimeStringfied =
          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";

      return formatterDateStringfied.contains(selectedTimeStringfied);
    }).toList();
  }
}
