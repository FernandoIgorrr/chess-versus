import 'package:flutter/material.dart';

ListTileThemeData listTileTheme(ColorScheme colorScheme) => ListTileThemeData(
      tileColor: colorScheme.secondary,
      textColor: colorScheme.onPrimary,
      iconColor: colorScheme.onPrimary,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
