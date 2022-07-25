import 'package:flutter/material.dart';
import 'package:todo_list/components/shared/medium_label.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({Key? key}) : super(key: key);

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 16, bottom: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: 20,
              height: 20,
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: false,
                onChanged: (value) {},
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: const MediumLabel("Купить что то"),
                ),
                const Icon(Icons.info_outline)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
