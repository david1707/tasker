import 'package:flutter/material.dart';
import 'package:tasker/widgets/expanded_button.dart';

import '../models/todo_item.dart';
import 'todo_listtile.dart';

class TodoListView extends StatefulWidget {
  final List<TodoItem> todoList;
  final Function toogleFinished;
  final Function removeItemFromList;
  const TodoListView({
    super.key,
    required this.todoList,
    required this.toogleFinished,
    required this.removeItemFromList,
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
          secondaryBackground: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.green,
            child: const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.remove_red_eye,
                color: Colors.white,
              ),
            ),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
            } else {
              return showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Delete todo'),
                  content: const Text('Confirm delete this todo'),
                  actions: [
                    Row(
                      children: [
                        ExpandedButton(
                          text: 'Close',
                          function: () => Navigator.of(context).pop(false),
                        ),
                        const SizedBox(width: 40),
                        ExpandedButton(
                          text: 'Delete',
                          function: () {
                            Navigator.of(context).pop(true);
                            widget.removeItemFromList(index);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return null;
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
