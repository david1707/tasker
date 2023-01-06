import 'package:flutter/material.dart';

import '../constants/colours.dart';
import '../models/todo_item.dart';

class TodoDetailScreen extends StatelessWidget {
  static const routeName = '/todo-detail';

  const TodoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)!.settings.arguments as TodoItem;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.kTeal,
        title: const Text("Todo detailed view"),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 20),
          Text(
            todo.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 30),
          Text(
            todo.body,
            style: const TextStyle(fontSize: 20),
          ),
        ]),
      ),
    );
  }
}
