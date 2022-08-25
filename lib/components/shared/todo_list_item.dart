import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/provider_models.dart/tasks_provider.dart';
import 'package:todo_list/components/shared/small_label.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/navigation/navigation_controller.dart';
import 'package:todo_list/themes/dark_theme.dart';

class TodoListItem extends StatefulWidget {
  final TodoModel model;

  const TodoListItem({required this.model, Key? key}) : super(key: key);

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  late Color _importanceColor;

  @override
  void initState() {
    var importanceColorString =
        FirebaseRemoteConfig.instance.getString("importanceColor");

    _importanceColor = Color(int.parse(importanceColorString));
    super.initState();
  }

  Widget _importanceIcon() {
    if (widget.model.importance == "basic") return const SizedBox.shrink();
    if (widget.model.importance == "important") {
      return SizedBox(
        width: 27,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 7,
              child: Icon(
                Icons.priority_high_rounded,
                color: _importanceColor,
              ),
            ),
            SizedBox(
              width: 7,
              child: Icon(
                Icons.priority_high_rounded,
                color: _importanceColor,
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox(
        width: 25,
        height: 25,
        child: Icon(
          Icons.arrow_downward_rounded,
        ),
      );
    }
  }

  ThemeData _checkboxTheme() {
    return darkTheme.copyWith(
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(
            Theme.of(context).appBarTheme.backgroundColor),
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).textTheme.displayMedium!.color;
            } else {
              if (widget.model.importance == "important") {
                return _importanceColor;
              } else {
                return Theme.of(context).iconTheme.color;
              }
            }
          },
        ),
      ),
    );
  }

  String dateToString(DateTime date) => DateFormat('dd.MM.yyyy').format(date);

  @override
  Widget build(BuildContext context) {
    var model = context.read<TasksProvider>();
    return Dismissible(
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30),
        color: Theme.of(context).textTheme.displayMedium!.color,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        color: Theme.of(context).textTheme.displaySmall!.color,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          model.updateItem(
              widget.model.changeFields(done: true, changedAt: DateTime.now()));
          return false;
        } else {
          model.deleteItem(widget.model);
          return true;
        }
      },
      key: ValueKey(widget.model.id),
      child: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 19, top: 16, bottom: 16, right: 16),
            child: Consumer<TasksProvider>(
              builder: (context, todoProvider, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: widget.model.importance == "basic"
                                ? const EdgeInsets.only(right: 15)
                                : const EdgeInsets.only(right: 7),
                            width: 20,
                            height: 20,
                            child: Theme(
                              data: _checkboxTheme(),
                              child: Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: widget.model.done,
                                onChanged: (value) {
                                  model.updateItem(
                                    widget.model.changeFields(
                                      done: value,
                                      changedAt: DateTime.now(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          if (widget.model.importance != "basic")
                            _importanceIcon(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  widget.model.text,
                                  style: widget.model.done
                                      ? Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough,
                                          )
                                      : Theme.of(context).textTheme.titleMedium,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (widget.model.deadline != null)
                                SmallLabel(
                                    dateToString(widget.model.deadline!)),
                            ],
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        GetIt.I<NavigationController>()
                            .gotoUpdateTodoScreen(widget.model);
                      },
                      child: const Icon(Icons.info_outline),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
