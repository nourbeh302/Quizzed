import 'package:flutter/material.dart';

class AddQuizScreen extends StatelessWidget {
  const AddQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Quiz'),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Add quiz screen'),
      ),
    );
  }
}
