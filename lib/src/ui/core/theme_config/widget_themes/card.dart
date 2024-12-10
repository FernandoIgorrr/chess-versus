import 'package:flutter/material.dart';

CardTheme cardTheme(ColorScheme colorScheme) => CardTheme(

    // color: colorScheme.secondaryContainer,
    elevation: 4,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: colorScheme.primary, width: 9),
    ));
