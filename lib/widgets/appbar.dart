import 'package:flutter/material.dart';

class QuizzedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonActive;
  const QuizzedAppBar(
      {super.key, required this.title, required this.isBackButtonActive});

  @override
  State<QuizzedAppBar> createState() => _QuizzedAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(58);
}

class _QuizzedAppBarState extends State<QuizzedAppBar> {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.isBackButtonActive,
      title: Text(widget.title),
      elevation: 0,
    );
  }
}
