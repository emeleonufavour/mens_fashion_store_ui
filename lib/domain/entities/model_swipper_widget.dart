import 'package:fashion_ecommerce_ui/core/constants.dart';
import 'package:flutter/material.dart';

class ModelSwipperWidget {
  final int order;
  final double scale;
  final double xOffset;
  final Widget child;
  final int totalCount;

  const ModelSwipperWidget({
    required this.order,
    required this.child,
    required this.totalCount,
  })  : scale = 1 - (order * Constants.scaleFraction),
        xOffset = order * Constants.xOffset;

  static List<ModelSwipperWidget> listFromWidgets(List<Widget> children) {
    return List.generate(
      children.length,
      (i) => ModelSwipperWidget(
        order: i,
        child: children[i],
        totalCount: children.length,
      ),
    ).reversed.toList();
  }
}
