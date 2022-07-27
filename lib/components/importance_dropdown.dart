import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/update_todo_screen.dart';

class ImportanceDropdown extends StatefulWidget {
  const ImportanceDropdown({Key? key}) : super(key: key);

  @override
  State<ImportanceDropdown> createState() => _ImportanceDropdownState();
}

class _ImportanceDropdownState extends State<ImportanceDropdown> {
  String importanceString = "Нет";

  String _importanceParsed(String imp) {
    switch (imp) {
      case "Нет":
        return "low";
      case "Низкий":
        return "basic";
      case "Высокий":
        return "high";
    }
    return "low";
  }

  @override
  Widget build(BuildContext context) {
    var model = context.read<TodoFormProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: DropdownButton<String>(
            hint: Text(
              "Важность",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            value: null,
            style: const TextStyle(color: Colors.white),
            icon: const SizedBox.shrink(),
            underline: Transform.translate(
              offset: const Offset(0, 20),
              child: Text(
                importanceString,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            onChanged: (String? newValue) {
              importanceString = newValue!;
              model.importance = _importanceParsed(newValue);
              setState(() {});
            },
            items: ['Нет', 'Низкий', 'Высокий'].map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
