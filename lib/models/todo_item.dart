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

  TodoItem({
    required this.id,
    required this.title,
    required this.body,
    this.priorities = Priorities.medium,
    required this.isFinished,
  });
}
