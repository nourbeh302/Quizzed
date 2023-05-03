// import 'package:flutter/material.dart';

// class AddQuestionScreen extends StatelessWidget {
//   const AddQuestionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     dynamic questionCount =
//         ModalRoute.of(context)!.settings.arguments as String;
//     questionCount = int.parse(questionCount);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Questions'),
//         elevation: 0,
//       ),
//       body: QuestionView(questionCount: questionCount),
//     );
//   }
// }

// class QuestionView extends StatefulWidget {
//   final questionCount;
//   const QuestionView({super.key, required this.questionCount});

//   @override
//   State<QuestionView> createState() => _QuestionViewState();
// }

// class _QuestionViewState extends State<QuestionView> {
//   @override
//   Widget build(BuildContext context) {
//     var questionList = <Widget>[];
//     for (var i = 0; i < widget.questionCount; i++) {
//       questionList.add(
//         Container(
//           color: Colors.red,
//         ),
//       );
//     }
//     return Column(
//       children: questionList,
//     );
//   }
// }

import 'package:flutter/material.dart';

class AddQuestionScreen extends StatelessWidget {
  const AddQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var questionCount = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Questions'),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [QuestionView(questionCount: questionCount)],
        ),
      ),
    );
  }
}

class QuestionView extends StatefulWidget {
  final int questionCount;
  const QuestionView({super.key, required this.questionCount});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  @override
  Widget build(BuildContext context) {
    var questionList = <Widget>[];
    for (var i = 1; i <= widget.questionCount; i++) {
      questionList.add(
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
          color: Colors.yellow,
          width: double.infinity,
          child: Text(i.toString()),
        ),
      );
    }
    return Column(
      children: questionList,
    );
  }
}
