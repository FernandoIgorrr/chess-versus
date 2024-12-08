import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../../config/local_storage.dart';

class ThemeService {
  Brightness? getLocalTheme() {
    String? jsonString = localStorage.getItem(LocalStorageKey.theme);

    if (jsonString != null) {
      if (jsonString.toLowerCase() == 'dark') {
        return Brightness.dark;
      } else {
        return Brightness.light;
      }
    }
    return null;
  }

  saveLocalTheme(ThemeMode themeMode) {
    localStorage.setItem(LocalStorageKey.theme, themeMode.name);
  }
}
