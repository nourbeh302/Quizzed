import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzed/providers/auth_provider.dart';

class TrackStudentsScreen extends StatefulWidget {
  const TrackStudentsScreen({super.key});

  @override
  State<TrackStudentsScreen> createState() => _TrackStudentsScreenState();
}

class _TrackStudentsScreenState extends State<TrackStudentsScreen> {
  AuthProvider authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();

    authProvider.addListener(() => print('Hello world'));
  }

  @override
  void dispose() {
    super.dispose();

    authProvider.removeListener(() => print('Widget destroyed'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Students'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Hello world'),
            OutlinedButton(
              onPressed: null,
              child: Text(
                'Emit events',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
