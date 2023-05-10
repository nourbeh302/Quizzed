import 'package:flutter/material.dart';

class FinalScoreScreen extends StatelessWidget {
  const FinalScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Score'),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text('Final Score Screen'),
      ),
    );
  }
}
