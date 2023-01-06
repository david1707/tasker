import 'package:flutter/material.dart';

import '../models/todo_item.dart';
import 'todo_listtile.dart';

class TodoListView extends StatefulWidget {
  final List<TodoItem> todoList;
  final Function toogleFinished;
  final Function confirmDismiss;
  const TodoListView({
    super.key,
    required this.todoList,
    required this.toogleFinished,
    required this.confirmDismiss,
  });

  @override
  State<TodoListView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    List<TodoItem> todoList = widget.todoList;

    return ListView.builder(
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(todoList[index].id),
          confirmDismiss: (direction) {
            return showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Delete todo'),
                content: const Text('Confirm delete this todo'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Close'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text('Delete'),
                  ),
                ],
              ),
            );
          },
          child: ToDoListTile(
            todo: todoList[index],
            toogleFinished: widget.toogleFinished,
          ),
          onDismissed: (_) {},
        );
      },
      itemCount: todoList.length,
    );
  }
}
