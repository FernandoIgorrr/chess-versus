import 'package:flutter/material.dart';

CardThemeData cardTheme(ColorScheme colorScheme) => CardThemeData(

    // color: colorScheme.secondaryContainer,
    elevation: 4,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: colorScheme.primary, width: 9),
    ));
