import 'package:chess_versus/src/config/local_storage.dart';
import 'package:chess_versus/src/data/exceptions/local_storage_key_not_found_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangService {
  final String _kLang = LocalStorageKeys.klang;

  Future<void> setLang(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLang, value);
  }

  Future<String> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kLang)) {
      throw LocalStorageKeyNotFoundException(
        'key $_kLang not found on local storage',
      );
    }
    return prefs.getString(_kLang) ?? '';
  }
}
