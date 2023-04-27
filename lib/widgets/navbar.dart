import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzed/constant.dart';
// import 'package:quizzed/screens/course/view_courses.dart';
// import 'package:quizzed/screens/home/home.dart';

class QuizzedNavbar extends StatefulWidget {
  const QuizzedNavbar({super.key});

  @override
  State<QuizzedNavbar> createState() => _QuizzedNavbarState();
}

class _QuizzedNavbarState extends State<QuizzedNavbar> {
  static int _selectedIndex = 0;

  var routes = [
    '/', 
    '/courses', 
    '/monitor', 
    '/profile'
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pushNamedAndRemoveUntil(context, routes[index], (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: primaryColor,
      showUnselectedLabels: true,
      unselectedItemColor: primaryColor,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
          ),
          label: "Home",
          backgroundColor: Colors.amber.shade50,
          activeIcon: SvgPicture.asset(
            'assets/icons/home-1.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: "Courses",
            activeIcon: SvgPicture.asset(
              'assets/icons/bookmark-1.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            )),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/eye.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: "Monitor",
            activeIcon: SvgPicture.asset(
              'assets/icons/eye-1.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            )),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/user.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
            label: "Profile",
            activeIcon: SvgPicture.asset(
              'assets/icons/user-1.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            )),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
