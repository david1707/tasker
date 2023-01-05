import 'package:flutter/material.dart';

import '../constants/colours.dart';
import '../models/todo_item.dart';
import '../widgets/showModalListTile.dart';

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
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  showModalListTile(
                      icon: Icons.preview_outlined,
                      text: "View '${todo.title}'",
                      todo: todo,
                      function: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Size mqSize = MediaQuery.of(context).size;

                            return Center(
                              child: Container(
                                color: Colours.kWhiteBackground,
                                width: mqSize.width * 0.80,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(height: 15),
                                    Text(
                                      todo.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Text(
                                      todo.body,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Current state: ${todo.isFinished ? "Finished" : "Pending"}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colours.kTeal,
                                            ),
                                            child: const Text('Edit'),
                                          ),
                                        ),
                                        Spacer(),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colours.kTeal,
                                            ),
                                            child: const Text('Close'),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                  showModalListTile(
                      icon: Icons.edit,
                      text: "Edit '${todo.title}'",
                      todo: todo,
                      function: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            //TODO Add Navigation to another page to edit this ToDo
                            return Text('');
                          },
                        );
                      }),
                ],
              );
            });
      },
      child: ListTile(
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
            color: Colours.kTeal,
          ),
        ),
      ),
    );
  }
}
