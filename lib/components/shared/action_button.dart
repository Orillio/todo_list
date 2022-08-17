import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;

  final Function() onPress;

  const ActionButton({
    required this.onPress,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).textTheme.displayLarge!.color,
        ),
      ),
    );
  }
}
