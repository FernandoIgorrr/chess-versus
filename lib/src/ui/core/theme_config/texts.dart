import 'package:flutter/material.dart';

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
    titleLarge: const TextStyle(
      //color: colorScheme.onPrimary,
      fontFamily: 'Scaatliches',
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    headlineLarge: TextStyle(
      color: colorScheme.onPrimaryContainer,
      fontFamily: 'Scaatliches',
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    titleMedium: TextStyle(
      color: colorScheme.onPrimaryContainer,
      fontFamily: 'Scaatliches',
      fontWeight: FontWeight.w400,
      fontSize: 18,
    ),

    /// Para o título de erro
    headlineSmall: TextStyle(
      color: colorScheme.error,
      fontSize: 22,
      // fontFamily: 'Scaatliches',
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      color: colorScheme.secondary,
      fontFamily: 'Scaatliches',
      fontSize: 18,
    ),
    displayMedium: TextStyle(
      color: colorScheme.onPrimary,
      fontFamily: 'Scaatliches',
      fontSize: 18,
      // fontFamily: 'Scaatliches',
      //fontWeight: FontWeight.w500,
    ),
    displaySmall: TextStyle(
      color: colorScheme.onPrimaryContainer,
      fontFamily: 'Scaatliches',
      fontSize: 16,
      // fontFamily: 'Scaatliches',
      //fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: colorScheme.surface,
      fontFamily: 'Scaatliches',
      fontSize: 16,
      // fontFamily: 'Scaatliches',
      //fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      color: colorScheme.onPrimary,
      fontFamily: 'Scaatliches',
      fontSize: 16,
    ),

    /// Para a mensagem de erro
    bodySmall: const TextStyle(color: Colors.white, fontSize: 16),
  );
}
