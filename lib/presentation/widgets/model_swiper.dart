import 'package:fashion_ecommerce_ui/core/constants.dart';
import 'package:fashion_ecommerce_ui/domain/entities/model_swipper_widget.dart';
import 'package:fashion_ecommerce_ui/presentation/widgets/model_widget.dart';

import 'package:fashion_ecommerce_ui/presentation/widgets/model_swiper_wrapper.dart';
import 'package:flutter/material.dart';

class ModelSwiper extends StatefulWidget {
  final List<Widget> children;
  final double initAnimationOffset;
  final double modelWidth;

  const ModelSwiper({
    super.key,
    required this.children,
    this.initAnimationOffset = Constants.initAnimationOffset,
    this.modelWidth = Constants.modelWidth,
  });

  @override
  State<ModelSwiper> createState() => _ModelSwiperState();
}

class _ModelSwiperState extends State<ModelSwiper>
    with SingleTickerProviderStateMixin {
  late final AnimationController backgroundModelsAnimationController;

  late final List<Widget> stackChildren;
  final ValueNotifier<bool> _backgroundModelsAreInFrontNotifier =
      ValueNotifier<bool>(false);
  bool fireBackgroundCardsAnimation = false;

  late final List<ModelSwipperWidget> _models;

  List<Widget> get _stackChildren => List.generate(
        _models.length,
        (i) {
          return ModelWidget(
            key: ValueKey('__animated_card_${i}__'),
            width: widget.modelWidth,
            initAnimationOffset: widget.initAnimationOffset,
            onAnimationTrigger: _onAnimationTrigger,
            onHorizontalDragEnd: () {},
            modelSwipper: _models[i],
          );
        },
      );

  void _onAnimationTrigger() async {
    setState(() {
      fireBackgroundCardsAnimation = true;
    });
    backgroundModelsAnimationController.forward();
    Future.delayed(Constants.backgroundModelsAnimationDuration).then(
      (_) {
        _backgroundModelsAreInFrontNotifier.value = true;
      },
    );
    Future.delayed(Constants.swipeAnimationDuration).then(
      (_) {
        _backgroundModelsAreInFrontNotifier.value = false;
        backgroundModelsAnimationController.reset();
        _swapLast();
      },
    );
  }

  void _swapLast() {
    Widget last = stackChildren[stackChildren.length - 1];

    setState(() {
      stackChildren.removeLast();
      stackChildren.insert(0, last);
    });
  }

  @override
  void initState() {
    super.initState();
    _models = ModelSwipperWidget.listFromWidgets(widget.children);
    stackChildren = _stackChildren;

    backgroundModelsAnimationController = AnimationController(
      vsync: this,
      duration: Constants.backgroundModelsAnimationDuration,
    );
  }

  @override
  void dispose() {
    backgroundModelsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: _backgroundModelsAreInFrontNotifier,
          builder: (c, bool backgroundModelsAreInFront, _) =>
              backgroundModelsAreInFront
                  ? Positioned(child: Container())
                  : _buildBackgroundModelsStack(),
        ),
        _buildFrontModel(),
        ValueListenableBuilder(
          valueListenable: _backgroundModelsAreInFrontNotifier,
          builder: (c, bool backgroundModelsAreInFront, _) =>
              backgroundModelsAreInFront
                  ? _buildBackgroundModelsStack()
                  : Positioned(child: Container()),
        ),
      ],
    );
  }

  Widget _buildBackgroundModelsStack() {
    return Stack(
      children: List.generate(
        _models.length - 1,
        (i) => _buildStackChild(i),
      ),
    );
  }

  Widget _buildFrontModel() {
    return _buildStackChild(_models.length - 1);
  }

  Widget _buildStackChild(int i) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 50,
      child: IgnorePointer(
        ignoring: i != stackChildren.length - 1,
        child: ModelSwiperWrapper(
          animationController: backgroundModelsAnimationController,
          initialScale: _models[i].scale,
          initialXOffset: _models[i].xOffset,
          child: stackChildren[i],
        ),
      ),
    );
  }
}
