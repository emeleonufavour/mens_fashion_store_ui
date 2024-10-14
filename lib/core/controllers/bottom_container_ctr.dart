import 'package:flutter/material.dart';

class BottomContainerController {
  VoidCallback? _minimizeCallback;

  void minimize() {
    _minimizeCallback?.call();
  }

  void setMinimizeCallback(VoidCallback callback) {
    _minimizeCallback = callback;
  }
}
