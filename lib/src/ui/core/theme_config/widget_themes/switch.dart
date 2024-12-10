import 'package:flutter/material.dart';

SwitchThemeData switchTheme(ColorScheme colorScheme) => SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary; // Cor do "polegar" quando ligado
        }
        return colorScheme.primary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary; // Cor do "polegar" quando ligado
        }
        return colorScheme.surface; // Cor do "polegar" quando desligado
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary; // Cor do "polegar" quando ligado
        }
        return colorScheme.primary; // Cor do "polegar" quando desligado
      }),
    );
