import 'package:flutter/material.dart';

DialogTheme dialogTheme(ColorScheme colorScheme) => DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: colorScheme.surface,
      titleTextStyle: TextStyle(
        color: colorScheme.primary,
        fontSize: 22,
        //fontFamily: 'Scaatliches',
        fontWeight: FontWeight.w700,
      ),
      contentTextStyle:
          TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w500),
    );
