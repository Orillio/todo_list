import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/screens/update_todo_screen.dart';

class NavigationController {
  final GlobalKey<NavigatorState> _key = GlobalKey();
  GlobalKey<NavigatorState> get key => _key;

  void navigateBack() {
    _key.currentState?.pop();
  }

  Widget slideTransitionBuilder(BuildContext context, Animation animation,
      Animation secAnimation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  void navigateToNewTodoScreen() {
    _key.currentState?.push(PageRouteBuilder(
        pageBuilder: (_, __, ___) => const UpdateTodoScreen(),
        transitionsBuilder: slideTransitionBuilder));
  }

  void navigateToUpdateTodoModelScreen(TodoModel model) {
    _key.currentState?.push(PageRouteBuilder(
        pageBuilder: (_, __, ___) => UpdateTodoScreen(model: model),
        transitionsBuilder: slideTransitionBuilder));
  }
}
