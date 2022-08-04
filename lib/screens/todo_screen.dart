import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/todo_list.dart';
import 'package:todo_list/navigation/navigation_controller.dart';

import '../components/todo_list_header.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class VisibilityChangeNotifier extends ChangeNotifier {
  bool _isVisible = true;

  bool get isVisible => _isVisible;

  set isVisible(bool isVisible) {
    _isVisible = isVisible;
    notifyListeners();
  }
}

class _TodoScreenState extends State<TodoScreen> {

  @override
  Widget build(BuildContext context) {
    var model = context.read<NavigationController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          model.navigateToNewTodoScreen();
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ChangeNotifierProvider(
          create: (_) => VisibilityChangeNotifier(),
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: TodoListHeader(
                  minimumExtent: 120,
                  maximumExtent: 230,
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 50, left: 8, right: 8),
                  child: TodoList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
