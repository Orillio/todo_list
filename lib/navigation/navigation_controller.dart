import 'package:flutter/material.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:todo_list/screens/update_todo_screen.dart';
import 'package:todo_list/themes/dark_theme.dart';

class NavigationController extends ChangeNotifier {
  final GlobalKey<NavigatorState> _key = GlobalKey();
  GlobalKey<NavigatorState> get key => _key;

  void navigateBack() {
    _key.currentState?.pop();
  }

  void navigateToNewTodoScreen() {
    _key.currentState?.push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => UpdateTodoScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        }
      )
    );
  }
}
