import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzed/constant.dart';

class QuizzedNavbar extends StatefulWidget {
  const QuizzedNavbar({super.key});

  @override
  State<QuizzedNavbar> createState() => _QuizzedNavbarState();
}

class _QuizzedNavbarState extends State<QuizzedNavbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
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
            backgroundColor: scaffoldColor,
            activeIcon: SvgPicture.asset(
              'assets/icons/home-1.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            )),
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
