import 'package:chess_versus/src/config/local_storage.dart';
import 'package:chess_versus/src/data/exceptions/local_storage_key_not_found_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  final String _kDarkMode = LocalStorageKeys.kDarkMode;

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kDarkMode, value);
  }

  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kDarkMode)) {
      throw LocalStorageKeyNotFoundException(
          'key $_kDarkMode not found on local storage');
    }
    return prefs.getBool(_kDarkMode) ?? false;
  }
}
