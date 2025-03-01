import 'dart:async';

import 'package:chess_versus/src/data/exceptions/local_storage_key_not_found_exception.dart';
import 'package:result_dart/result_dart.dart';

import '../../services/theme_service.dart';

class ThemeRepository {
  final _darkModeController = StreamController<bool>.broadcast();

  final ThemeService _service;

  ThemeRepository(
    this._service,
  );

  /// Get if dark mode is enabled
  AsyncResult<bool, Exception> isDarkMode() async {
    try {
      final value = await _service.isDarkMode();
      return Success(value);
    } on LocalStorageKeyNotFoundException catch (e) {
      return Failure(e);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  /// Set dark mode
  AsyncResult<void, Exception> setDarkMode(bool value) async {
    try {
      await _service.setDarkMode(value);
      _darkModeController.add(value);
      return const Success(unit);
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  Stream<bool> observeDarkMode() => _darkModeController.stream;
}
// #enddocregion ThemeRepository