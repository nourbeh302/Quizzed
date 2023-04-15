import 'package:flutter/material.dart';
import 'package:quizzed/constant.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) =>
      CircularProgressIndicator(backgroundColor: primaryColor);
}
