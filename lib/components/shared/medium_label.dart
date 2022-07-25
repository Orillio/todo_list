import 'package:flutter/material.dart';

class MediumLabel extends StatelessWidget {
  final String text;
  const MediumLabel(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelMedium,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
