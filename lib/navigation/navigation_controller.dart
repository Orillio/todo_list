import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:todo_list/screens/update_todo_screen.dart';

class GoRouterController {
  late final GoRouter goRouter;

  GoRouterController() {
    goRouter = GoRouter(routes: [
      GoRoute(
        path: "/",
        name: "list",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const TodoScreen(),
          transitionsBuilder: _slideTransitionBuilder,
        ),
      ),
      GoRoute(
        path: "/create",
        name: "create",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const UpdateTodoScreen(),
          transitionsBuilder: _slideTransitionBuilder,
        ),
      ),
      GoRoute(
        path: "/:id",
        name: "specific todo",
        pageBuilder: (context, state) => CustomTransitionPage(
          child: UpdateTodoScreen(
            model: state.extra is TodoModel ? state.extra as TodoModel : null,
            modelId: state.params['id'],
          ),
          transitionsBuilder: _slideTransitionBuilder,
        ),
      ),
    ]);
  }

  void gotoUpdateTodoScreen(TodoModel parameter) {
    goRouter.push("/${parameter.id}", extra: parameter);
  }

  void gotoCreateTodoScreen() {
    goRouter.push("/create");
  }

  void gotoTodoList() {
    try {
      goBack();
    } catch (e) {
      goRouter.push("/");
    }
  }

  void goBack() {
    goRouter.pop();
  }

  Widget _slideTransitionBuilder(BuildContext context, Animation animation,
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
}
