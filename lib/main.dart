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
    Color backgroundColor = const Color.fromARGB(255, 240, 240, 240);
    Color foregroundColor = const Color.fromARGB(255, 72, 55, 87);

    // String _title = _widgetsList.elementAt(_selectedIndex) as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Name',
          style: TextStyle(fontFamily: 'DMSans'),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 0,
      ),
      body: Center(
        child: _widgetsList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: foregroundColor,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
              ),
              label: "Home",
              backgroundColor: backgroundColor,
              activeIcon: SvgPicture.asset(
                'assets/icons/home-1.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/bookmark.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
              ),
              label: "Courses",
              backgroundColor: backgroundColor,
              activeIcon: SvgPicture.asset(
                'assets/icons/bookmark-1.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/eye.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
              ),
              label: "Monitor",
              backgroundColor: backgroundColor,
              activeIcon: SvgPicture.asset(
                'assets/icons/eye-1.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
              )),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
              ),
              label: "Profile",
              backgroundColor: backgroundColor,
              activeIcon: SvgPicture.asset(
                'assets/icons/user-1.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
              )),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
