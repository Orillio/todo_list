import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/business/provider_models.dart/tasks_provider.dart';
import 'package:todo_list/components/shared/medium_label.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var model = context.watch<TasksProvider>();
    var visibilityModel = context.watch<VisibilityChangeNotifier>();

    double negativeRelationValue =
        (1 - (shrinkOffset / (maxExtent - minExtent))).clamp(0, 1);
    double positiveRelationValue =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);

    double titleXOffset = lerpDouble(0, -40, positiveRelationValue)!;
    double titleYOffset = lerpDouble(0, 35, positiveRelationValue)!;
    double labelXOffset = lerpDouble(0, -50, positiveRelationValue)!;
    double labelYOffset = lerpDouble(0, 30, positiveRelationValue)!;
    double visibilityXOffset = lerpDouble(-50, 0, positiveRelationValue)!;

    double titleFontSize = lerpDouble(20, 32, negativeRelationValue)!;
    double labelOpacity = negativeRelationValue;
    double backgroundOpacity = positiveRelationValue;

    return OrientationBuilder(builder: (context, orientation) {
      return Material(
        animationDuration: Duration.zero,
        color: Theme.of(context).scaffoldBackgroundColor,
        shadowColor:
            Theme.of(context).canvasColor.withOpacity(0.4 * backgroundOpacity),
        elevation: 5,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                    ? const EdgeInsets.only(bottom: 26, right: 25, left: 65)
                    : const EdgeInsets.only(bottom: 26, right: 45, left: 105),
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
                          AppLocalizations.of(context)!.myTodos,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: titleFontSize,
                              color: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .color),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Transform.translate(
                            offset: Offset(labelXOffset, labelYOffset),
                            child: Opacity(
                              opacity: labelOpacity,
                              child: MediumLabel(
                                "${AppLocalizations.of(context)!.itemsDone} - ${model.itemsDone}",
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? Offset(visibilityXOffset, 0)
                                : const Offset(0, 0),
                            child: GestureDetector(
                              onTap: () {
                                visibilityModel.isVisible =
                                    !visibilityModel.isVisible;
                              },
                              child: Builder(
                                builder: (context) {
                                  if (visibilityModel.isVisible) {
                                    return Icon(
                                      Icons.visibility,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color,
                                    );
                                  } else {
                                    return Icon(
                                      Icons.visibility_off,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .color,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
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
