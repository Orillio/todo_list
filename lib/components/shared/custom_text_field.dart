import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: TextField(
        minLines: 4,
        maxLines: null,
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          height: 24 / 16,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(bottom: 16, left: 16, top: 16, right: 16),
          hintText: AppLocalizations.of(context)!.whatToDo,
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.labelSmall!.color,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
      ),
    );
  }
}
