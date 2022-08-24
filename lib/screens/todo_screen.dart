import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/todo_list.dart';

import '../components/todo_list_header.dart';
import '../navigation/navigation_controller.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          GetIt.I<NavigationController>().gotoCreateTodoScreen();
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ChangeNotifierProvider(
            create: (_) => VisibilityChangeNotifier(),
            child: OrientationBuilder(builder: (context, orientation) {
              double minExt = orientation == Orientation.portrait ? 120 : 70;
              double maxExt = orientation == Orientation.portrait ? 230 : 140;
              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: TodoListHeader(
                      minimumExtent: minExt,
                      maximumExtent: maxExt,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 50, left: 8, right: 8),
                      child: TodoList(),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
