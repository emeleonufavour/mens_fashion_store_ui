import 'package:fashion_ecommerce_ui/domain/entities/model_swipper_widget.dart';
import 'package:flutter/material.dart';

class ModelWidget extends StatefulWidget {
  final ModelSwipperWidget modelSwipper;
  final Function onAnimationTrigger;
  final Function onHorizontalDragEnd;
  final double width;
  final double initAnimationOffset;

  const ModelWidget({
    super.key,
    required this.modelSwipper,
    required this.onAnimationTrigger,
    required this.onHorizontalDragEnd,
    required this.width,
    required this.initAnimationOffset,
  });

  @override
  State<ModelWidget> createState() => _ModelWidgetState();
}

class _ModelWidgetState extends State<ModelWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  late final Animation<Offset> slideAnimation;
  late final Animation<double> scaleAnimation;

  double xDragOffset = 0;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      xDragOffset += details.delta.dx;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if ((xDragOffset.abs()) > widget.initAnimationOffset) {
      widget.onAnimationTrigger();
      animationController.forward().then((value) {
        widget.onHorizontalDragEnd();
      });
    } else {
      setState(() {
        xDragOffset = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    slideAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.5, 0),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(-0.5, 0),
          end: const Offset(1.5, 0),
        ),
        weight: 1,
      ),
    ]).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCubic,
    ));

    scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCubic,
    ));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          double dragProgress =
              (xDragOffset.abs() / widget.initAnimationOffset).clamp(0.0, 1.0);
          double scale = 1 - (0.2 * dragProgress);

          return Transform.translate(
            offset: Offset(
              xDragOffset +
                  slideAnimation.value.dx * MediaQuery.of(context).size.width,
              0,
            ),
            child: Transform.scale(
              scale: scaleAnimation.value * scale,
              child: widget.modelSwipper.child,
            ),
          );
        },
      ),
    );
  }
}
