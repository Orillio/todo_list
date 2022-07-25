import 'package:flutter/material.dart';

class SmallLabel extends StatelessWidget {
  final String text;
  const SmallLabel(this.text ,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}
