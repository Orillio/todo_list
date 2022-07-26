import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/i_todo_provider.dart';
import 'package:todo_list/components/shared/medium_label.dart';

class TodoListHeader extends SliverPersistentHeaderDelegate {
  final double maximumExtent;
  final double minimumExtent;

  TodoListHeader({
    required this.minimumExtent,
    required this.maximumExtent,
  });


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    var model = context.watch<ITodoProvider>();

    double negativeRelationValue = (1 - (shrinkOffset / (maxExtent - minExtent))).clamp(0, 1);
    double positiveRelationValue = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);

    double bottomPadding = lerpDouble(0, 26, negativeRelationValue)!;
    double leftPadding = lerpDouble(20, 65, negativeRelationValue)!;
    double titleFontSize = lerpDouble(20, 32, negativeRelationValue)!;
    double labelOpacity = negativeRelationValue;
    double backgroundOpacity = positiveRelationValue;
    double visibilityIconOffset = lerpDouble(-30, 0, negativeRelationValue)!;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .appBarTheme
                  .backgroundColor!
                  .withOpacity(backgroundOpacity),
            ),
            padding: EdgeInsets.only(bottom: bottomPadding, right: 25, left: leftPadding),
            height: maxExtent,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Мои дела",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: titleFontSize
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                        opacity: labelOpacity,
                        child: MediumLabel(
                          "Выполнено - ${model.itemsDone}",
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, visibilityIconOffset),
                        child: const Icon(Icons.visibility),
                      ),
                    ]
                  ),
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



  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

}
