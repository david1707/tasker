import 'package:flutter/material.dart';

import '/constants/kColours.dart';
import '/models/todo_item.dart';
import '/widgets/todo_listtile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tasker',
      debugShowCheckedModeBanner: false,
      color: Colors.teal,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ToDoItem> todoList = [
    ToDoItem(
      id: '01',
      title: 'Test',
      body:
          'Hahaha this is a test! But on this one, the text is a big longer to I can cut it :)',
      isFinished: false,
    ),
    ToDoItem(
      id: '02',
      title: 'Another test',
      body: 'Hahaha this is a test!',
      isFinished: false,
    ),
    ToDoItem(
      id: '03',
      title: 'Eat all the lunchables',
      body: 'Hahaha this is a test!',
      isFinished: true,
    ),
    ToDoItem(
      id: '04',
      title: 'Yell',
      body: 'Hahaha this is a test!',
      isFinished: true,
    ),
    ToDoItem(
      id: '05',
      title: 'Read @dril tweets',
      body: 'Hahaha this is a test!',
      isFinished: false,
    ),
    ToDoItem(
      id: '06',
      title: 'Drive thru the Mc Donalds',
      body: 'Hahaha this is a test!',
      isFinished: true,
    ),
  ];

  void _toogleFinished(String id) {
    ToDoItem todo = todoList.firstWhere((item) => item.id == id);
    setState(() {
      todo.isFinished = !todo.isFinished;
    });
  }

  void _removeItemFromList(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  Future<bool> _confirmDismiss(direction, index) {
    //TODO: Add a showModal to ask the user to confirm if they want to remove the ToDoItem
    if (direction == DismissDirection.endToStart) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "'${todoList[index].title}' item removed.",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          backgroundColor: kColours.kRedClear,
        ),
      );
      _removeItemFromList(index);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(todoList[index].id),
              confirmDismiss: (direction) => _confirmDismiss(direction, index),
              child: ToDoListTile(
                todo: todoList[index],
                toogleFinished: _toogleFinished,
              ),
            );
          },
          itemCount: todoList.length,
        ),
      ),
    );
  }
}
