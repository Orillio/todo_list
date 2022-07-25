import 'package:flutter/material.dart';

class LargeTitle extends StatelessWidget {
  final String title;

  const LargeTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
