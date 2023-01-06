import 'package:flutter/material.dart';
import 'package:tasker/widgets/todo_listview.dart';

import '/constants/colours.dart';
import 'models/todo_item.dart';
import 'widgets/custom_fab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasker',
      debugShowCheckedModeBanner: false,
      color: Colours.kTeal,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoItem> todoList = [
    TodoItem(
      id: '01',
      title: 'Test',
      body:
          'Hahaha this is a test! But on this one, the text is a big longer to I can cut it :)',
      isFinished: false,
    ),
    TodoItem(
      id: '02',
      title: 'Another test',
      body: 'Hahaha this is a test!',
      isFinished: false,
    ),
    TodoItem(
      id: '03',
      title: 'Eat all the lunchables',
      body: 'Hahaha this is a test!',
      isFinished: true,
    ),
    TodoItem(
      id: '04',
      title: 'Yell',
      body: 'Hahaha this is a test!',
      isFinished: true,
    ),
    TodoItem(
      id: '05',
      title: 'Read @dril tweets',
      body: 'Hahaha this is a test!',
      isFinished: false,
    ),
    TodoItem(
      id: '06',
      title: 'Drive thru the Mc Donalds',
      body: 'Hahaha this is a test!',
      isFinished: true,
    ),
  ];

  void _toogleFinished(String id) {
    TodoItem todo = todoList.firstWhere((item) => item.id == id);
    setState(() {
      todo.isFinished = !todo.isFinished;
    });
  }

  void _removeItemFromList(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  void _addNewTodo(TodoItem todo) {
    setState(() {
      todoList.insert(0, todo);
    });
  }

  Future<bool> _confirmDismiss(direction, index) {
    //TODO: Add a showModal to ask the user to confirm if they want to remove the TodoItem
    if (direction == DismissDirection.endToStart) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "'${todoList[index].title}' item removed.",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          backgroundColor: Colours.kRedClear,
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
        backgroundColor: Colours.kTeal,
      ),
      body: Container(
          alignment: Alignment.center,
          child: TodoListView(
            todoList: todoList,
            toogleFinished: _toogleFinished,
            confirmDismiss: _confirmDismiss,
          )),
      floatingActionButton: CustomFAB(addNewToDo: _addNewTodo),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
