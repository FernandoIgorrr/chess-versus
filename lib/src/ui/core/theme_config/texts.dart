import 'package:flutter/material.dart';

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
      titleLarge: TextStyle(
        color: colorScheme.onPrimary,
        //fontFamily: 'Scaatliches',
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      titleMedium: TextStyle(
        color: colorScheme.onPrimary,
        //fontFamily: 'Scaatliches',
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),

      // para tútulos fora de lugares on o background seja da cor principal
      bodyLarge:
          TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w700),

      /// Para o título de erro
      headlineSmall: TextStyle(
        color: colorScheme.onError,
        fontSize: 22,
        // fontFamily: 'Scaatliches',
        fontWeight: FontWeight.w500,
      ),

      /// Para a mensagem de erro
      bodySmall: const TextStyle(
        color: Colors.black,
      ));
}
