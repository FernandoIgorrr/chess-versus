import 'package:flutter/material.dart';

ListTileThemeData listTileTheme(ColorScheme colorScheme) => ListTileThemeData(
      tileColor: colorScheme.primary,
      textColor: colorScheme.onPrimary,
      iconColor: colorScheme.onPrimary,
    );
