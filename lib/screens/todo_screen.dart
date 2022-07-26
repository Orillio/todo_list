import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/i_todo_provider.dart';
import 'package:todo_list/components/todo_list.dart';
import 'package:todo_list/navigation/navigation_controller.dart';

import '../components/todo_list_header.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    var model = context.read<NavigationController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          model.navigateToNewTodoScreen();
        },
      ),

      body: RefreshIndicator(
        onRefresh: () async {  },
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: TodoListHeader(minimumExtent: 120, maximumExtent: 230),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 50, left: 8, right: 8),
                child: TodoList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
