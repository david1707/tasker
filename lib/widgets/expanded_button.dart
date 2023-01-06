import 'package:flutter/material.dart';

import '../constants/colours.dart';

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
