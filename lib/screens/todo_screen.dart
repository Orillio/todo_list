import 'package:flutter/material.dart';
import 'package:todo_list/components/shared/large_title.dart';
import 'package:todo_list/components/todo_list.dart';

import '../components/todo_list_header.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TodoListHeader(minimumExtent: 120, maximumExtent: 230),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TodoList(),
            )
          ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     child: ListView.builder(
          //       physics: NeverScrollableScrollPhysics(),
          //       shrinkWrap: true,
          //       itemCount: 50,
          //       itemBuilder: (context, index) {
          //         return const Padding(
          //           padding: EdgeInsets.all(10),
          //           child: Text("1 thing to do is to do"),
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
