import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  Widget build(BuildContext context) {
    var navControllerProvider = context.read<NavigationController>();
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 16),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 6,
            child: GestureDetector(
              onTap: () {
                navControllerProvider.navigateToNewTodoScreen();
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
        ],
      ),
    );
  }
}
