import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/i_todo_provider.dart';
import 'package:todo_list/components/custom_text_field.dart';
import 'package:todo_list/components/date_picker.dart';
import 'package:todo_list/components/importance_dropdown.dart';
import 'package:todo_list/components/shared/action_button.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/navigation/navigation_controller.dart';
import 'package:todo_list/themes/dark_theme.dart';
import 'package:uuid/uuid.dart';

class TodoFormProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  String _importance = "Нет";

  TodoFormProvider();

  TodoFormProvider.fromOldModel(TodoModel model) {
    controller.text = model.text;
    _importance = model.importance;
    _deadline = model.deadline;
    if (model.deadline != null) {
      _deadlineString = DateFormat.yMMMMd("ru").format(model.deadline!);
    }
  }

  String get importance => _importance;

  set importance(String importance) {
    _importance = importance;
    notifyListeners();
  }

  DateTime? _deadline;

  DateTime? get deadline => _deadline;

  set deadline(DateTime? deadline) {
    _deadline = deadline;
    notifyListeners();
  }

  String? _deadlineString;

  String? get deadlineString => _deadlineString;

  set deadlineString(String? deadlineString) {
    _deadlineString = deadlineString;
    notifyListeners();
  }
}

class UpdateTodoScreen extends StatefulWidget {
  final TodoModel? model;

  const UpdateTodoScreen({this.model, Key? key}) : super(key: key);

  @override
  State<UpdateTodoScreen> createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        if (widget.model == null) {
          return TodoFormProvider();
        } else {
          return TodoFormProvider.fromOldModel(widget.model!);
        }
      },
      child: Consumer3<TodoFormProvider, NavigationController, ITodoProvider>(
        builder: (context, provider, navController, todoProvider, child) {
          return GestureDetector(
            onTap: FocusScope.of(context).unfocus,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: GestureDetector(
                  onTap: () => navController.navigateBack(),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: ActionButton(
                      onPress: () {
                        if (provider.controller.text.isEmpty) return;
                        if (widget.model == null) {
                          todoProvider.addItem(TodoModel(
                            id: const Uuid().v4(),
                            lastUpdatedBy: const Uuid().v4(),
                            text: provider.controller.text,
                            done: false,
                            importance: provider.importance,
                            deadline: provider.deadline,
                            createdAt: DateTime.now(),
                            changedAt: DateTime.now(),
                          ));
                        } else {
                          todoProvider.updateItem(widget.model!
                            ..text = provider.controller.text
                            ..deadline = provider.deadline
                            ..importance = provider.importance
                            ..changedAt = DateTime.now()
                          );
                        }
                        navController.navigateBack();
                      },
                      text: "сохранить",
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            controller: provider.controller,
                          ),
                          const ImportanceDropdown(),
                          const SizedBox(height: 16),
                          const Divider(
                            height: 30,
                          ),
                          const DatePicker(),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              navController.navigateBack();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.delete,
                                      color: ConstColors.colorRed,
                                    ),
                                  ),
                                  Text(
                                    "Удалить",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: ConstColors.colorRed),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
