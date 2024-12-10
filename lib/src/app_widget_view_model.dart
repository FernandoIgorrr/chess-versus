import 'dart:async';

import 'package:chess_versus/src/data/repositories/theme/theme_repository.dart';
import 'package:flutter/material.dart';

import 'ui/core/theme_config/view_models/theme_state.dart';

class AppWidgetViewModel extends ChangeNotifier {
  final ThemeRepository _themeRepository;
  late ThemeState _state = LightThemeState();
  StreamSubscription<bool>? _subscription;

  ThemeState get state => _state;

  AppWidgetViewModel(this._themeRepository) {
    _subscription = _themeRepository.observeDarkMode().listen(emit);
    _load();
  }

  bool get _isDarkModeFromSystem =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? true
          : false;

  void emit(bool isDarkMode) {
    _state = isDarkMode ? DarkThemeState() : LightThemeState();
    notifyListeners();
  }

  Future<void> _load() async {
    (await _themeRepository.isDarkMode()).fold(emit, (failure) {
      emit(_isDarkModeFromSystem);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
