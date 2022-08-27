import 'package:flutter/material.dart';

class SlidingForwardPage extends Page {
  final Widget child;

  const SlidingForwardPage({required this.child, LocalKey? key})
      : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionsBuilder: (context, animation, secondaryAnimation, c) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: c,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return child;
      },
    );
  }
}
