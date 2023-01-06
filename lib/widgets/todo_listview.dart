import 'package:flutter/material.dart';

import '../constants/colours.dart';
import '../models/todo_item.dart';
import '../screens/todo_detail_screen.dart';
import '../widgets/expanded_button.dart';
import './todo_listtile.dart';

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
            color: Colours.kRedClear,
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          background: Container(
            alignment: AlignmentDirectional.centerStart,
            color: Colours.kGreenClear,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Icon(
                Icons.remove_red_eye,
                color: Colors.white,
              ),
            ),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              Navigator.pushNamed(
                context,
                TodoDetailScreen.routeName,
                arguments: todoList[index],
              );
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "'${todoList[index].title}' item removed.",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                backgroundColor: Colours.kRedClear,
                                duration: const Duration(seconds: 3),
                              ),
                            );
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
