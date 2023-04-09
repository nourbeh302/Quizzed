import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzed/constant.dart';
import 'package:quizzed/models/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final User? loggedInUser = Auth().loggedInUser;

  Future<void> signOut() async {
    await Auth().signOut();
    navigateToLogInScreen();
  }

  void navigateToLogInScreen() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        title: Text(
          "Home",
          style:
              TextStyle(fontFamily: baseFontFamily, fontSize: appBarFontSize),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${Auth().loggedInUser?.email}'),
            TextButton(
                onPressed: () => signOut(),
                child: Text(
                  "Sign out",
                  style: TextStyle(fontFamily: baseFontFamily),
                ))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
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
              backgroundColor: scaffoldColor,
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
              backgroundColor: scaffoldColor,
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
              backgroundColor: scaffoldColor,
              activeIcon: SvgPicture.asset(
                'assets/icons/user-1.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
              )),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
