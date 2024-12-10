import 'package:chess_versus/src/data/repositories/theme/theme_repository.dart';
import 'package:flutter/material.dart';

import 'theme_state.dart';

class ThemeSwitchViewModel extends ChangeNotifier {
  final ThemeRepository _themeRepository;
  ThemeState _state = DarkThemeState();

  ThemeSwitchViewModel(this._themeRepository) {
    _load();
  }

  ThemeState get state => _state;
  void get toggle => _toggle();

  void emit(bool isDarkMode) {
    _state = isDarkMode ? DarkThemeState() : LightThemeState();
    notifyListeners();
  }

  _load() async {
    (await _themeRepository.isDarkMode()).fold(emit, (failure) {});
  }

  _toggle() async {
    await _themeRepository.setDarkMode(state is LightThemeState);
    emit(state is LightThemeState);
  }
}
