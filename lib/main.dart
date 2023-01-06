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
      body: 'This is a test!',
      isFinished: false,
    ),
    TodoItem(
      id: '02',
      title: 'Another test',
      body:
          'Yep, another test. But the text on this one is longer so we can see how we limit characters being ',
      isFinished: false,
    ),
    TodoItem(
      id: '03',
      title: 'Eat all the lunchables',
      body: 'This is a test!',
      isFinished: true,
    ),
    TodoItem(
      id: '04',
      title: 'Yell',
      body: 'This is a test!',
      isFinished: true,
    ),
    TodoItem(
      id: '05',
      title: 'Read @dril tweets',
      body: 'This is a test!',
      isFinished: false,
    ),
    TodoItem(
      id: '06',
      title: 'Drive thru the Mc Donalds',
      body: 'This is a test!',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.kTeal,
        title: Text("Total items: ${todoList.length}"),
      ),
      body: Container(
          alignment: Alignment.center,
          child: TodoListView(
            todoList: todoList,
            toogleFinished: _toogleFinished,
            removeItemFromList: _removeItemFromList,
          )),
      floatingActionButton: CustomFAB(addNewToDo: _addNewTodo),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
