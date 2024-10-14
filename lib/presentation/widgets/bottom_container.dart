import 'package:fashion_ecommerce_ui/core/controllers/bottom_container_ctr.dart';
import 'package:flutter/material.dart';

class BottomContainer extends StatefulWidget {
  final Widget child;
  final BottomContainerController controller;
  final VoidCallback? onMinimize;

  const BottomContainer({
    super.key,
    required this.child,
    required this.controller,
    this.onMinimize,
  });

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  double _containerHeight = 200.0;
  static const double _minHeight = 200.0;
  static const double _maxHeight = 500.0;

  @override
  void initState() {
    super.initState();
    widget.controller.setMinimizeCallback(_minimize);
  }

  void _minimize() {
    setState(() {
      _containerHeight = _minHeight;
    });
    widget.onMinimize?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          _containerHeight -= details.delta.dy;
          _containerHeight = _containerHeight.clamp(_minHeight, _maxHeight);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: _containerHeight,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: _containerHeight < _maxHeight
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              GestureDetector(
                onTap: _minimize,
                child: Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
