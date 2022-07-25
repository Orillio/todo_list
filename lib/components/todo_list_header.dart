import 'package:flutter/material.dart';
import 'package:todo_list/components/shared/large_title.dart';
import 'package:todo_list/components/shared/small_label.dart';

class TodoListHeader extends SliverPersistentHeaderDelegate {
  final double maximumExtent;
  final double minimumExtent;

  TodoListHeader({
    required this.minimumExtent,
    required this.maximumExtent,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor!
                  .withOpacity((shrinkOffset / minimumExtent).clamp(0, 1)),
            ),
            padding: EdgeInsets.only(bottom: 26, right: 20, left: 60),
            height: maxExtent,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  LargeTitle(title: "Мои дела",),
                  SmallLabel("Выполнено - 5",),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => maximumExtent;

  @override
  double get minExtent => minimumExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
