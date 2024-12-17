import 'package:flutter/material.dart';

InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) =>
    InputDecorationTheme(
      //fillColor: colorScheme.secondary,
      //filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.onPrimary,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.secondary,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 1,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      floatingLabelStyle: TextStyle(
        color: colorScheme.primary,
      ),
      floatingLabelAlignment: FloatingLabelAlignment.center,
      alignLabelWithHint: true,

      labelStyle: TextStyle(
        color: colorScheme.primary,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,

      hintStyle: TextStyle(
        color: colorScheme.secondary,
      ),
    );
