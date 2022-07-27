import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/i_todo_provider.dart';
import 'package:todo_list/components/shared/medium_label.dart';
import 'package:todo_list/themes/dark_theme.dart';

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

    double titleXOffset = lerpDouble(0, -50, positiveRelationValue)!;
    double titleYOffset = lerpDouble(0, 35, positiveRelationValue)!;
    double labelXOffset = lerpDouble(0, -50, positiveRelationValue)!;
    double labelYOffset = lerpDouble(0, 30, positiveRelationValue)!;

    double titleFontSize = lerpDouble(20, 32, negativeRelationValue)!;
    double labelOpacity = negativeRelationValue;
    double backgroundOpacity = positiveRelationValue;

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
            padding: const EdgeInsets.only(bottom: 26, right: 25, left: 65),
            height: maxExtent,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.translate(
                    offset: Offset(titleXOffset, titleYOffset),
                    child: Text(
                      "Мои дела",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: titleFontSize
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.translate(
                        offset: Offset(labelXOffset, labelYOffset),
                        child: Opacity(
                          opacity: labelOpacity,
                          child: MediumLabel(
                            "Выполнено - ${model.itemsDone}",
                          ),
                        ),
                      ),
                      const Icon(Icons.visibility, color: ConstColors.colorBlue,),
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
