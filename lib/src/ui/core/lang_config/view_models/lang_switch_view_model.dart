import 'package:chess_versus/src/data/repositories/lang/lang_repository.dart';
import 'package:flutter/material.dart';

class LangSwitchViewModel extends ChangeNotifier {
  final LangRepository _langRepository;
  Locale _state = Locale('en');

  LangSwitchViewModel(this._langRepository) {
    _load();
  }

  Locale get state => _state;
  void toggle(Locale lang) => _toggle(lang);

  void emit(Locale locale) {
    _state = locale;
    notifyListeners();
  }

  Future<void> _load() async {
    (await _langRepository.getLang()).fold(emit, (failure) {});
  }

  Future<void> _toggle(Locale lang) async {
    await _langRepository.setLang(lang);
    emit(lang);
  }
}
