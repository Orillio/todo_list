import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/custom_text_field.dart';
import 'package:todo_list/components/date_picker.dart';
import 'package:todo_list/components/importance_dropdown.dart';
import 'package:todo_list/components/shared/action_button.dart';
import 'package:todo_list/navigation/navigation_controller.dart';

class TodoFormProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  String _importance = "Нет";

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
  const UpdateTodoScreen({Key? key}) : super(key: key);

  @override
  State<UpdateTodoScreen> createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoFormProvider(),
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () => context.read<NavigationController>().navigateBack(),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: ActionButton(
                  onPress: () {},
                  text: "сохранить",
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<TodoFormProvider>(
                      builder: (context, provider, child) {
                        return CustomTextField(
                          controller: provider.controller,
                        );
                      },
                    ),
                    const ImportanceDropdown(),
                    const SizedBox(height: 16),
                    const Divider(height: 30,),
                    const DatePicker(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
