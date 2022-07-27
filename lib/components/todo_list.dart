import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/i_todo_provider.dart';
import 'package:todo_list/components/shared/todo_list_item.dart';
import 'package:todo_list/navigation/navigation_controller.dart';

import '../models/todo_model.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ITodoProvider, NavigationController>(
      builder: (context, provider, navController, child) {
        return FutureBuilder<List<TodoModel>>(
          future: provider.getItemsFromNetwork(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.secondary),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return TodoListItem(
                          model: snapshot.data![index],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 22),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: SizedBox.shrink(),
                          ),
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () {
                                navController.navigateToNewTodoScreen();
                              },
                              child: Text("Новое",
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontSize: 16
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
    );
  }
}
