import 'package:flutter/material.dart';

ListTileThemeData listTileTheme(ColorScheme colorScheme) => ListTileThemeData(
      tileColor: colorScheme.primaryContainer,
      textColor: colorScheme.onPrimaryContainer,
      iconColor: colorScheme.onPrimaryContainer,
      selectedColor: colorScheme.tertiary,
      titleTextStyle: TextStyle(
        color: colorScheme.onPrimaryContainer,
        fontSize: 20,
        fontFamily: 'Scaatliches',
        //fontWeight: FontWeight.w700,
      ),
      subtitleTextStyle: TextStyle(
        color: colorScheme.onPrimaryContainer,
        fontSize: 16,
        //fontFamily: 'Scaatliches',
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
