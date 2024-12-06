import 'package:flutter/material.dart';

InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) =>
    InputDecorationTheme(
      //fillColor: colorScheme.secondary,
      //filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.onPrimary,
          width: 22,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.onPrimary,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.onPrimary,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      floatingLabelStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontFamily: 'Scaatliches',
      ),
      floatingLabelAlignment: FloatingLabelAlignment.center,
      alignLabelWithHint: true,

      /* labelStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontFamily: 'Scaatliches',
      ),*/
      //floatingLabelBehavior: FloatingLabelBehavior.never,
      hintStyle: TextStyle(
        color: colorScheme.onPrimary,
        fontFamily: 'Scaatliches',
      ),
    );
