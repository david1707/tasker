import 'package:flutter/material.dart';

import '../constants/colours.dart';

class Custom_FAB extends StatefulWidget {
  const Custom_FAB({
    Key? key,
  }) : super(key: key);

  @override
  State<Custom_FAB> createState() => _Custom_FABState();
}

class _Custom_FABState extends State<Custom_FAB> {
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
                children: [],
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
                    Navigator.of(context).pop();
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
