import 'package:flutter/material.dart';

import '../constants/colours.dart';

class PaddedRowButtons extends StatelessWidget {
  const PaddedRowButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        children: [
          ExpandedButton(
            function: () => {
              //TODO Add Navigation to another page to edit this ToDo
            },
            text: 'Edit',
          ),
          const SizedBox(width: 40),
          ExpandedButton(
            function: () => Navigator.of(context).pop(),
            text: 'Close',
          ),
        ],
      ),
    );
  }
}

class ExpandedButton extends StatelessWidget {
  final String text;
  final Function function;

  const ExpandedButton({Key? key, required this.text, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => function(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colours.kTeal,
        ),
        child: Text(text),
      ),
    );
  }
}
