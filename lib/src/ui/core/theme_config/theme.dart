import 'package:chess_versus/src/ui/core/theme_config/widget_themes/card.dart';
import 'package:chess_versus/src/ui/core/theme_config/widget_themes/dialog.dart';
import 'package:chess_versus/src/ui/core/theme_config/widget_themes/elevated_button.dart';
import 'package:chess_versus/src/ui/core/theme_config/widget_themes/icons.dart';
import 'package:chess_versus/src/ui/core/theme_config/widget_themes/input_decoration.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'texts.dart';
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
      iconTheme: iconTheme(colorScheme),
      dialogTheme: dialogTheme(colorScheme),
      colorScheme: _supportedColors[theme],
      textTheme: TextThemes.textTheme(colorScheme),
      appBarTheme: appBarTheme(colorScheme),
      listTileTheme: listTileTheme(colorScheme),
      switchTheme: switchTheme(colorScheme),
      inputDecorationTheme: inputDecorationTheme(colorScheme),
      cardTheme: cardTheme(colorScheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme),
    );
  }
}
