import 'package:flutter/material.dart';

sealed class LangState {
  late final Locale locale;
}

class IdleLangState extends LangState {}

class EnLangState extends LangState {
  @override
  final Locale locale = Locale('es');
}

class PtLangState extends LangState {
  @override
  final Locale locale = Locale('pt');
}

class EsLangState extends LangState {
  @override
  final Locale locale = Locale('es');
}
