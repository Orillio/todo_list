import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../screens/update_todo_screen.dart';

class ImportanceDropdown extends StatefulWidget {
  const ImportanceDropdown({Key? key}) : super(key: key);

  @override
  State<ImportanceDropdown> createState() => _ImportanceDropdownState();
}

class _ImportanceDropdownState extends State<ImportanceDropdown> {
  String importanceString = "Нет";

  String _importanceParsed(String imp) {
    if (imp == AppLocalizations.of(context)!.importanceLow) {
      return "low";
    } else if (imp == AppLocalizations.of(context)!.importanceBasic) {
      return "basic";
    } else {
      return "important";
    }
  }

  String _reverseImportanceParsed(String imp) {
    switch (imp) {
      case "low":
        return AppLocalizations.of(context)!.importanceLow;
      case "basic":
        return AppLocalizations.of(context)!.importanceBasic;
      case "important":
        return AppLocalizations.of(context)!.importanceHigh;
    }
    return AppLocalizations.of(context)!.importanceLow;
  }

  @override
  Widget build(BuildContext context) {
    var model = context.read<TodoFormProvider>();
    importanceString = _reverseImportanceParsed(model.importance);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: DropdownButton<String>(
            hint: Text(
              AppLocalizations.of(context)!.importance,
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
            items: [
              AppLocalizations.of(context)!.importanceLow,
              AppLocalizations.of(context)!.importanceBasic,
              AppLocalizations.of(context)!.importanceHigh,
            ].map(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
