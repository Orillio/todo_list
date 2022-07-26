import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/shared/action_button.dart';
import 'package:todo_list/navigation/navigation_controller.dart';

class UpdateTodoScreen extends StatefulWidget {
  const UpdateTodoScreen({Key? key}) : super(key: key);

  @override
  State<UpdateTodoScreen> createState() => _UpdateTodoScreenState();
}

class _UpdateTodoScreenState extends State<UpdateTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPress: () {
              },
              text: "сохранить",
            ),
          )
        ],
      ),
    );
  }
}
