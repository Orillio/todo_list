import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/i_todo_provider.dart';
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
  Widget _importanceIcon() {
    if (widget.model.importance == "basic") return const SizedBox.shrink();
    if (widget.model.importance == "important") {
      return SizedBox(
        width: 16,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              width: 8,
              child: Icon(
                Icons.priority_high_rounded,
                color: ConstColors.colorRed,
              ),
            ),
            SizedBox(
              width: 8,
              child: Icon(
                Icons.priority_high_rounded,
                color: ConstColors.colorRed,
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox(
        width: 20,
        child: Icon(Icons.arrow_downward_rounded),
      );
    }
  }

  ThemeData _checkboxTheme() {
    return darkTheme.copyWith(
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(ConstColors.backSecondary),
        fillColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return ConstColors.colorGreen;
            } else {
              if (widget.model.importance == "important") {
                return ConstColors.colorRed;
              } else {
                return ConstColors.supportSeparator;
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
    var model = context.read<ITodoProvider>();
    return Dismissible(
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 30),
        color: ConstColors.colorGreen,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        color: ConstColors.colorRed,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          model.updateItem(widget.model.changeFields(
            done: true,
          ));
          return false;
        } else {
          model.deleteItem(widget.model);
          return true;
        }
      },
      key: UniqueKey(),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 20,
                height: 20,
                child: Theme(
                  data: _checkboxTheme(),
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: widget.model.done,
                    onChanged: (value) {
                      model.updateItem(widget.model.changeFields(
                        done: value,
                      ));
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.model.importance != "basic")
                    Expanded(
                      child: _importanceIcon(),
                    ),
                  Expanded(
                    flex: 8,
                    child: Column(
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
                                        decoration: TextDecoration.lineThrough)
                                : Theme.of(context).textTheme.titleMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.model.deadline != null)
                          SmallLabel(dateToString(widget.model.deadline!)),
                      ],
                    ),
                  ),
                  Consumer<NavigationController>(
                    builder: (context, navController, _) {
                      return GestureDetector(
                        onTap: () {
                          navController
                              .navigateToUpdateTodoModelScreen(widget.model);
                        },
                        child: const Icon(Icons.info_outline),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
