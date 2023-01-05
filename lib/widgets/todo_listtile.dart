import 'package:flutter/material.dart';

import '../models/todo_item.dart';

class ToDoListTile extends StatelessWidget {
  final ToDoItem todo;
  final Function toogleFinished;
  const ToDoListTile({
    Key? key,
    required this.todo,
    required this.toogleFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: todo.body.length >= 30
          ? Text('${todo.body.characters.take(30)} ...')
          : Text(todo.body),
      leading: InkWell(
        onTap: () => toogleFinished(todo.id),
        child: Icon(
          todo.isFinished ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.teal,
        ),
      ),
    );
  }
}
