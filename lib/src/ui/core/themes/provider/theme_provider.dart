import 'package:chess_versus/src/data/services/theme_service.dart';
import 'package:flutter/material.dart';

import 'theme_state.dart';

class ThemeProvider extends ChangeNotifier {
  final themeService = ThemeService();
  static ThemeProvider? _instance;

  ThemeProvider._();

  ThemeState state = LightThemeState();

  static ThemeProvider getInstance() {
    return _instance ??= ThemeProvider._();
  }

  loadTheme() {
    var brightness = themeService.getLocalTheme();
    if (brightness != null) {
      setSystemTheme(brightness);
      return;
    }
    setSystemTheme(
        WidgetsBinding.instance.platformDispatcher.platformBrightness);
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
    themeService.saveLocalTheme(state.themeMode);
    notifyListeners();
  }
}
