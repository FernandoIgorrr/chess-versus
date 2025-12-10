import 'dart:async';

import 'package:chess_versus/src/data/repositories/lang/lang_repository.dart';
import 'package:chess_versus/src/data/repositories/theme/theme_repository.dart';
import 'package:flutter/material.dart';

import 'ui/core/theme_config/view_models/theme_state.dart';

class AppWidgetViewModel extends ChangeNotifier {
  final LangRepository _langRepository;
  final ThemeRepository _themeRepository;
  late ThemeState _state = LightThemeState();
  late Locale _locale = Locale('en');

  StreamSubscription<bool>? _subscription;
  StreamSubscription<Locale>? _lsubscription;
  //late LangState _lstate = EnLangState();
  ThemeState get state => _state;
  Locale get locale => _locale;
  AppWidgetViewModel(this._themeRepository, this._langRepository) {
    _subscription = _themeRepository.observeDarkMode().listen(emit);
    _lsubscription = _langRepository.observeLang().listen(langEmit);
    _load();
    _loadLocale();
  }

  bool get _isDarkModeFromSystem =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark
      ? true
      : false;

  Locale get _localeFromSystem =>
      WidgetsBinding.instance.platformDispatcher.locale;

  void emit(bool isDarkMode) {
    _state = isDarkMode ? DarkThemeState() : LightThemeState();
    notifyListeners();
  }

  void langEmit(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  Future<void> _loadLocale() async {
    (await _langRepository.getLang()).fold(langEmit, (failure) {
      langEmit(_localeFromSystem);
    });
  }

  Future<void> _load() async {
    (await _themeRepository.isDarkMode()).fold(emit, (failure) {
      emit(_isDarkModeFromSystem);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _lsubscription?.cancel();
    super.dispose();
  }
}
