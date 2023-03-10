import 'package:flutter/material.dart';

enum Priorities {
  low,
  medium,
  high,
}

class TodoItem {
  final String id;
  final String title;
  final String body;
  final Priorities priorities;
  bool isFinished;

  Color get getPriorityColour {
    switch (priorities) {
      case Priorities.low:
        return Colors.green;
      case Priorities.medium:
        return Colors.yellow;
      case Priorities.high:
        return Colors.red;
      default:
        return Colors.blueAccent;
    }
  }

  String get getPriorityText {
    switch (priorities) {
      case Priorities.low:
        return 'Low';
      case Priorities.medium:
        return 'Medium';
      case Priorities.high:
        return 'High';
      default:
        return 'Error';
    }
  }

  TodoItem({
    required this.id,
    required this.title,
    required this.body,
    this.priorities = Priorities.medium,
    required this.isFinished,
  });
}
