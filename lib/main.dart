import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/providers/auth_provider.dart';
import 'package:quizzed/providers/course_provider.dart';
import 'package:quizzed/providers/quiz_provider.dart';
import 'package:quizzed/screens/course/add_course.dart';
import 'package:quizzed/screens/home/home.dart';
import 'package:quizzed/screens/auth/login.dart';
import 'package:quizzed/screens/auth/welcome.dart';
import 'package:quizzed/screens/course/single_course.dart';
import 'package:quizzed/screens/course/view_courses.dart';
import 'package:quizzed/screens/auth/register.dart';
import 'package:quizzed/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<CourseProvider>(
          create: (_) => CourseProvider(),
        ),
        ChangeNotifierProvider<QuizProvider>(
          create: (_) => QuizProvider(),
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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      theme: MyThemeData().getTheme(),
      title: _title,
      initialRoute: authProvider.loggedInUser != null ? '/' : '/Welcome',
      routes: {
        '/': (context) => const HomeScreen(),
        '/Welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/courses': (context) => const ViewCoursesScreen(),
        '/addCourse': (context) => const AddCourseScreen(),
        '/course': (context) => const SingleCourseScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
