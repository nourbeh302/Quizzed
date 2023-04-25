import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/constant.dart';
import 'package:quizzed/providers/course_provider.dart';
import 'package:quizzed/screens/shared/home.dart';
import 'package:quizzed/screens/shared/login.dart';
import 'package:quizzed/screens/shared/single_course.dart';
import 'package:quizzed/screens/shared/view_courses.dart';
import 'package:quizzed/screens/shared/welcome.dart';
import 'package:quizzed/screens/student/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CourseProvider>(
          create: (_) => CourseProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primarySwatch: MaterialState<Color>,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: primaryColor,
          contentTextStyle: TextStyle(fontSize: 16, fontFamily: baseFontFamily),
        ),
        appBarTheme: defaultAppBarTheme,
        elevatedButtonTheme: elevatedButtonThemeData,
        outlinedButtonTheme: outlinedButtonThemeData,
        fontFamily: baseFontFamily,
        scaffoldBackgroundColor: Colors.amber.shade50,
        textTheme: defaultTextTheme,
      ),
      title: _title,
      initialRoute: '/Welcome',
      routes: {
        '/': (context) => const HomeScreen(),
        '/Welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/courses': (context) => const ViewCoursesScreen(),
        // '/addCourse': (context) => const AddCourseScreen(),
        '/course': (context) => const SingleCourseScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
