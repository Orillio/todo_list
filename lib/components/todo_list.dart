import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/provider_models.dart/tasks_provider.dart';
import 'package:todo_list/components/shared/new_item_field.dart';
import 'package:todo_list/components/shared/todo_list_item.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var newItemTextContoller = TextEditingController();

  late Future<List<TodoModel>> todoList;

  @override
  void initState() {
    super.initState();
    var todoProvider = context.read<TasksProvider>();
    todoProvider.getTodoList();

  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<TodoModel>>(
      future: todoList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var isLandscape =
              MediaQuery.of(context).orientation == Orientation.landscape;
          return Padding(
            padding: isLandscape
                ? const EdgeInsets.symmetric(horizontal: 70)
                : EdgeInsets.zero,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.antiAlias,
              elevation: 3,
              color: Theme.of(context).colorScheme.secondary,
              child: Consumer<VisibilityChangeNotifier>(
                  builder: (context, visibilityProvider, _) {
                var todoProvider = context.watch<TasksProvider>();
                return ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == snapshot.data!.length) {
                      return Focus(
                        onFocusChange: (value) async {
                          if (!value && newItemTextContoller.text.isNotEmpty) {
                            todoProvider.addItem(
                              TodoModel(
                                id: const Uuid().v4(),
                                lastUpdatedBy:
                                    (await PlatformDeviceId.getDeviceId) ??
                                        const Uuid().v4(),
                                text: newItemTextContoller.text,
                                done: false,
                                importance: "basic",
                                createdAt: DateTime.now(),
                                changedAt: DateTime.now(),
                              ),
                            );
                            newItemTextContoller.clear();
                          }
                        },
                        child: NewItemField(
                          controller: newItemTextContoller,
                        ),
                      );
                    }
                    if (!snapshot.data![index].done ||
                        visibilityProvider.isVisible) {
                      return TodoListItem(
                        model: snapshot.data![index],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              }),
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
  }
}
