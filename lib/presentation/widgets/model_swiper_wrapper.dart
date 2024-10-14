import 'package:fashion_ecommerce_ui/core/constants.dart';
import 'package:flutter/material.dart';

class ModelSwiperWrapper extends StatefulWidget {
  final Widget child;
  final double initialScale;
  final double initialXOffset;
  final bool fire;
  final AnimationController animationController;

  const ModelSwiperWrapper({
    super.key,
    required this.child,
    this.initialScale = 1,
    this.initialXOffset = 0,
    this.fire = false,
    required this.animationController,
  });

  @override
  State<ModelSwiperWrapper> createState() => _ModelSwiperWrapperState();
}

class _ModelSwiperWrapperState extends State<ModelSwiperWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> xOffsetAnimation;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = widget.animationController;

    xOffsetAnimation = Tween<double>(
      begin: widget.initialXOffset,
      end: widget.initialXOffset - Constants.xOffset,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );

    scaleAnimation = Tween<double>(
      begin: widget.initialScale,
      end: widget.initialScale + Constants.scaleFraction,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (c, child) => Transform.translate(
        offset: Offset(-xOffsetAnimation.value, 0),
        child: Transform.scale(
          scale: scaleAnimation.value,
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
