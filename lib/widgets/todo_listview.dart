import 'package:flutter/material.dart';

import '../models/todo_item.dart';
import './todo_listtile.dart';

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
          confirmDismiss: (direction) =>
              widget.confirmDismiss(direction, index),
          child: ToDoListTile(
            todo: todoList[index],
            toogleFinished: widget.toogleFinished,
          ),
        );
      },
      itemCount: todoList.length,
    );
  }
}
