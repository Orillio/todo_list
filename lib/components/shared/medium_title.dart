import 'package:flutter/material.dart';

class MediumTitle extends StatelessWidget {
  final String text;
  const MediumTitle(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
