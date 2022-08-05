import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        minLines: 4,
        maxLines: null,
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: const Color.fromRGBO(237, 237, 237, 0.5),
        style: const TextStyle(
          height: 24 / 16,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(bottom: 16, left: 16, top: 16, right: 16),
          hintText: AppLocalizations.of(context)!.whatToDo,
          hintStyle: const TextStyle(
            color: Color.fromRGBO(237, 237, 237, 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF111111),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF111111),
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).appBarTheme.backgroundColor,
        ));
  }
}
