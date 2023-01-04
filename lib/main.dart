import 'package:flutter/material.dart';

import 'models/todo_item.dart';

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
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "'${todoList[index].title}' removed.",
                      ),
                    ),
                  );
                  setState(() {
                    todoList.removeAt(index);
                  });
                }
              },
              child: ListTile(
                title: Text(
                  todoList[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: todoList[index].body.length >= 30
                    ? Text('${todoList[index].body.characters.take(30)} ...')
                    : Text(todoList[index].body),
                leading: Icon(
                  todoList[index].isFinished
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: Colors.teal,
                ),
              ),
            );
          },
          itemCount: todoList.length,
        ),
      ),
    );
  }
}
