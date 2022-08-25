import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/shared/medium_title.dart';
import 'package:todo_list/screens/update_todo_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<TodoFormProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediumTitle(AppLocalizations.of(context)!.deadline),
            if (model.deadlineString != null)
              Padding(
                key: const ValueKey("deadline_date_switch"),
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  model.deadlineString!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                      ),
                ),
              )
          ],
        ),
        Switch(
          value: model.deadline != null,
          onChanged: (newVal) async {
            if (newVal) {
              var date = await showDatePicker(
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                model.deadline = date;
                model.deadlineString = DateFormat.yMMMd("ru").format(date);
                return;
              }
            }
            model.deadline = null;
            model.deadlineString = null;
          },
        )
      ],
    );
  }
}
