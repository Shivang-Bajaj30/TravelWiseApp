import 'package:flutter/material.dart';

/// Simple global theme controller to switch between dark and light premium themes.
class ThemeController extends ChangeNotifier {
  bool isLight = true;

  void toggle() {
    isLight = !isLight;
    notifyListeners();
  }

  ThemeMode get themeMode {
    return isLight ? ThemeMode.light : ThemeMode.dark;
  }
}

final ThemeController themeController = ThemeController();
