import 'package:flutter/material.dart';

import 'theme_state.dart';

class ThemeViewModel extends ChangeNotifier {
  static ThemeViewModel? _instance;

  ThemeViewModel._();

  ThemeState state = LightThemeState();

  static ThemeViewModel getInstance() {
    return _instance ??= ThemeViewModel._();
  }

  void setSystemTheme(Brightness brightness) {
    state =
        brightness == Brightness.dark ? DarkThemeState() : LightThemeState();
    notifyListeners();
  }

  ThemeMode get themeMode => state.themeMode;

  switchTheme() {
    if (state is LightThemeState) {
      state = DarkThemeState();
    } else if (state is DarkThemeState) {
      state = LightThemeState();
    }
    notifyListeners();
  }
}
