import 'package:flutter/material.dart';
import 'package:tasker/models/todo_item.dart';

class ShowModalListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final TodoItem todo;
  final Function function;

  const ShowModalListTile(
      {Key? key,
      required this.icon,
      required this.text,
      required this.todo,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
      onTap: () => {function()},
    );
  }
}
