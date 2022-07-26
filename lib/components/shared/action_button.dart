import 'package:flutter/material.dart';
import 'package:todo_list/themes/dark_theme.dart';

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
        style: const TextStyle(
          color: ConstColors.colorBlue,
        ),
      ),
    );
  }
}
