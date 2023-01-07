import 'package:flutter/material.dart';

import 'package:basic_utils/basic_utils.dart' show StringUtils;

import '../models/todo_item.dart';
import '../constants/colours.dart';

class CustomFAB extends StatefulWidget {
  final Function addNewToDo;
  const CustomFAB({Key? key, required this.addNewToDo}) : super(key: key);

  @override
  State<CustomFAB> createState() => CustomFABState();
}

class CustomFABState extends State<CustomFAB> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _body = '';
  Priorities _priorities = Priorities.medium;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colours.kTeal,
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Create a new ToDo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: Colours.kTeal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please, enter a title';
                          } else {
                            return null;
                          }
                        }),
                        onSaved: (value) {
                          _title = value.toString();
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Body',
                          labelStyle: TextStyle(
                            color: Colours.kTeal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please, enter a body';
                          } else if (value.length > 100) {
                            return 'The body is too long';
                          } else {
                            return null;
                          }
                        }),
                        onSaved: (value) {
                          _body = value.toString();
                        },
                      ),
                      DropdownButtonFormField<Priorities>(
                        value: _priorities,
                        items: Priorities.values.map((Priorities priorities) {
                          return DropdownMenuItem<Priorities>(
                            value: priorities,
                            child: Text(
                              StringUtils.capitalize(
                                priorities.toString().split('.')[1],
                              ),
                            ),
                          );
                        }).toList(),
                        onSaved: (value) {
                          _priorities = value!;
                        },
                        onChanged: (_) {},
                      ),
                    ]),
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.kTeal,
                  ),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      TodoItem todo = TodoItem(
                          id: DateTime.now().toString(),
                          title: _title,
                          body: _body,
                          priorities: _priorities,
                          isFinished: false);
                      widget.addNewToDo(todo);
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colours.kTeal,
                  ),
                  child: const Text('Create'),
                ),
              ],
              actionsAlignment: MainAxisAlignment.spaceAround,
            );
          },
        );
      },
    );
  }
}
