import 'package:flutter/material.dart';

class ScalePage extends Page {
  final Widget child;

  const ScalePage({required this.child, LocalKey? key}) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      transitionsBuilder: (context, animation, secondaryAnimation, c) {
        const begin = 0.8;
        const end = 1.0;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
          scale: animation.drive(tween),
          child: c,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return child;
      },
    );
  }
}
