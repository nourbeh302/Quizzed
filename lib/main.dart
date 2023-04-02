import 'package:flutter/material.dart';

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

  static const List<Widget> _widgetsList = <Widget>[
    Text(
      'Home',
    ),
    Text(
      'Courses',
    ),
    Text(
      'Monitor',
    ),
    Text(
      'Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzed'),
      ),
      body: Center(
        child: _widgetsList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              label: "Courses",
              icon: Icon(Icons.book),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              label: "Monitor",
              icon: Icon(Icons.monitor),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person),
              backgroundColor: Colors.blue),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
