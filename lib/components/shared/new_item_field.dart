import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/navigation/navigation_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewItemField extends StatefulWidget {
  const NewItemField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<NewItemField> createState() => _NewItemFieldState();
}

class _NewItemFieldState extends State<NewItemField> {
  late GoRouterController _navController;

  @override
  void initState() {
    super.initState();
    _navController = GetIt.I<GoRouterController>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 45),
              child: GestureDetector(
                onTap: () {
                  _navController.gotoCreateTodoScreen();
                },
                child: TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: AppLocalizations.of(context)!.newItem,
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(right: 30),
                    ),
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
