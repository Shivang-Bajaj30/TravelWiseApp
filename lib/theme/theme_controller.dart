import 'package:flutter/material.dart';

/// Simple global theme controller to switch between dark and light premium themes.
class ThemeController extends ChangeNotifier {
  bool isLight = false;

  void toggle() {
    isLight = !isLight;
    notifyListeners();
  }
}

final ThemeController themeController = ThemeController();
