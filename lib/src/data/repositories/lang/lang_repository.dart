import 'dart:async';
import 'dart:ui';

import 'package:chess_versus/src/data/exceptions/local_storage_key_not_found_exception.dart';
import 'package:chess_versus/src/data/services/lang_service.dart';
import 'package:result_dart/result_dart.dart';

class LangRepository {
  final _langController = StreamController<Locale>.broadcast();

  final LangService _service;

  LangRepository(this._service);

  /// Get if dark mode is enabled
  AsyncResult<Locale> getLang() async {
    try {
      final value = await _service.getLang();
      return Success(Locale(value));
    } on LocalStorageKeyNotFoundException catch (e) {
      return Failure(e);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  /// Set dark mode
  AsyncResult<void> setLang(Locale locale) async {
    try {
      await _service.setLang(locale.toLanguageTag());
      _langController.add(locale);
      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Stream<Locale> observeLang() => _langController.stream;
}
// #enddocregion ThemeRepository