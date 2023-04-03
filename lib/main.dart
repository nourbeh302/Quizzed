import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: RoutingWidget(),
    );
  }
}

class RoutingWidget extends StatefulWidget {
  const RoutingWidget({super.key});

  @override
  State<RoutingWidget> createState() => _RoutingWidgetState();
}

class _RoutingWidgetState extends State<RoutingWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'DMSans');

  static const List<Widget> _widgetsList = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Courses',
      style: optionStyle,
    ),
    Text(
      'Monitor',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorFilter whiteColor =
        const ColorFilter.mode(Colors.white, BlendMode.srcIn);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quizzed',
          style: TextStyle(fontFamily: 'DMSans'),
        ),
      ),
      body: Center(
        child: _widgetsList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 24,
                height: 24,
                colorFilter: whiteColor,
              ),
              label: "Home",
              backgroundColor: Colors.blue,
              activeIcon: SvgPicture.asset(
                'assets/icons/home-1.svg',
                width: 24,
                height: 24,
                colorFilter: whiteColor,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bookmark.svg',
                width: 24,
                height: 24,
                colorFilter: whiteColor,
              ),
              label: "Courses",
              backgroundColor: Colors.blue,
              activeIcon: SvgPicture.asset(
                'assets/icons/bookmark-1.svg',
                width: 24,
                height: 24,
                colorFilter: whiteColor,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/eye.svg',
                width: 24,
                height: 24,
                colorFilter: whiteColor,
              ),
              label: "Monitor",
              backgroundColor: Colors.blue,
              activeIcon: SvgPicture.asset(
                'assets/icons/eye-1.svg',
                width: 24,
                height: 24,
                colorFilter: whiteColor,
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 24,
                height: 24,
                colorFilter: whiteColor,
              ),
              label: "Profile",
              backgroundColor: Colors.blue,
              activeIcon: SvgPicture.asset(
                'assets/icons/user-1.svg',
                width: 24,
                height: 24,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              )),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
