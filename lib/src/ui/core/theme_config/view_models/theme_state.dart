import 'package:flutter/material.dart';

sealed class ThemeState {
  late final ThemeMode themeMode;
}

class IdleThemeState extends ThemeState {}

class LightThemeState extends ThemeState {
  @override
  // ignore: overridden_fields
  final ThemeMode themeMode = ThemeMode.light;
}

class DarkThemeState extends ThemeState {
  @override
  // ignore: overridden_fields
  final ThemeMode themeMode = ThemeMode.dark;
}
