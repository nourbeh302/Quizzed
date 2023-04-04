import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(58);

  @override
  AppBar build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 240, 240, 240);
    Color foregroundColor = const Color.fromARGB(255, 72, 55, 87);

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            'assets/icons/bell.svg',
            width: 28,
            height: 28,
            colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
          )
        ],
      ),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
    );
  }
}
