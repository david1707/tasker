import 'package:flutter/material.dart';
import 'package:tasker/screens/todo_detail_screen.dart';

import '/constants/colours.dart';
import '../screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasker',
      debugShowCheckedModeBanner: false,
      color: Colours.kTeal,
      initialRoute: MainScreen.routeName,
      routes: {
        MainScreen.routeName: (ctx) => const MainScreen(),
        TodoDetailScreen.routeName: (ctx) => const TodoDetailScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}
