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
      home: HomeWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(255, 240, 240, 240);
    Color foregroundColor = const Color.fromARGB(255, 72, 55, 87);

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Homepage".toUpperCase(),
              style: const TextStyle(
                  fontSize: 13,
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Color.fromARGB(255, 116, 116, 116)),
            ),
            const Text(
              "Welcome, professor",
              style: TextStyle(fontSize: 28, fontFamily: "DMSans"),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 255, 179, 104),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Be a real examiner",
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: "DMSans",
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "View your courses and add new quizzes for students",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "DMSans",
                      ),
                    ),
                    const Divider(
                      height: 32,
                      color: Colors.black54,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          backgroundColor: Colors.white,
                          shape: const StadiumBorder()),
                      // onPressed: () => print('Hello'),
                      onPressed: null,
                      child: const Text(
                        'Apply now',
                        style: TextStyle(
                            fontFamily: "DMSans", color: Colors.black),
                      ),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Latest courses",
              style: TextStyle(fontSize: 22, fontFamily: "DMSans"),
            ),
            Container(
              height: 211,
              margin: const EdgeInsetsDirectional.symmetric(vertical: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
                    child: InkWell(
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(133, 133, 133, 0.307),
                                offset: Offset(
                                  0.5,
                                  0.5,
                                ),
                                blurRadius: 2.0,
                                spreadRadius: 0.8,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color.fromARGB(255, 245, 245, 245)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/lock-1.svg',
                                    width: 36,
                                    height: 36,
                                    colorFilter: const ColorFilter.mode(
                                        Color.fromARGB(255, 66, 66, 66), BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Cybersecurity",
                                style: TextStyle(
                                    fontFamily: "DMSans", fontSize: 24),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 12),
                                    backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                                    shape: const StadiumBorder()),
                                // onPressed: () => print('Hello'),
                                onPressed: null,
                                child: const Text(
                                  'Go to courses',
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: InkWell(
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(133, 133, 133, 0.307),
                                offset: Offset(
                                  0.5,
                                  0.5,
                                ),
                                blurRadius: 2.0,
                                spreadRadius: 0.8,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color.fromARGB(255, 245, 245, 245)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/banknote-1.svg',
                                    width: 36,
                                    height: 36,
                                    colorFilter: const ColorFilter.mode(
                                        Color.fromARGB(255, 66, 66, 66), BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Trigonometry",
                                style: TextStyle(
                                    fontFamily: "DMSans", fontSize: 24),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 12),
                                    backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                                    shape: const StadiumBorder()),
                                // onPressed: () => print('Hello'),
                                onPressed: null,
                                child: const Text(
                                  'Go to courses',
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: InkWell(
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(133, 133, 133, 0.307),
                                offset: Offset(
                                  0.5,
                                  0.5,
                                ),
                                blurRadius: 2.0,
                                spreadRadius: 0.8,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color.fromARGB(255, 245, 245, 245)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/micro-1.svg',
                                    width: 36,
                                    height: 36,
                                    colorFilter: const ColorFilter.mode(
                                        Color.fromARGB(255, 66, 66, 66), BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "Listening",
                                style: TextStyle(
                                    fontFamily: "DMSans", fontSize: 24),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 12),
                                    backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                                    shape: const StadiumBorder()),
                                // onPressed: () => print('Hello'),
                                onPressed: null,
                                child: const Text(
                                  'Go to courses',
                                  style: TextStyle(
                                      fontFamily: "DMSans",
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
