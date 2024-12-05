import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/texts.dart';
import 'widget_themes/app_bar.dart';
import 'widget_themes/list_tile.dart';
import 'widget_themes/switch.dart';

ThemeData get lightTheme => ThemeHelper().lightThemeData;

ThemeData get darkTheme => ThemeHelper().darkThemeData;

class ThemeHelper {
  final Map<String, ColorScheme> _supportedColors = {
    'light': AppColors.lightCodeScheme,
    'dark': AppColors.darkCodeScheme,
  };

  ThemeData get lightThemeData => _getTheme('light');
  ThemeData get darkThemeData => _getTheme('dark');

  ThemeData _getTheme(String theme) {
    ColorScheme colorScheme =
        _supportedColors[theme] ?? AppColors.lightCodeScheme;
    return ThemeData(
        colorScheme: _supportedColors[theme],
        textTheme: TextThemes.textTheme(colorScheme),
        appBarTheme: appBarTheme(colorScheme),
        listTileTheme: listTileTheme(colorScheme),
        switchTheme: switchTheme(colorScheme));
  }
}
