import 'package:chess_versus/src/ui/core/lang_config/view_models/lang_switch_view_model.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key, required this.langSwitchViewModel});
  final LangSwitchViewModel langSwitchViewModel;

  @override
  Widget build(BuildContext context) {
    // final localeModel = context.watch<AppWidgetViewModel>();

    return ListenableBuilder(
      listenable: langSwitchViewModel,
      builder: (context, child) {
        return DropdownButton<Locale>(
          value: langSwitchViewModel.state,
          items: const [
            DropdownMenuItem(value: Locale('en'), child: Text("English")),
            DropdownMenuItem(value: Locale('es'), child: Text("Español")),
            DropdownMenuItem(value: Locale('pt'), child: Text("Português")),
            DropdownMenuItem(
              value: Locale('it'),
              child: Text("Italiano"),
            ), // Italiano
            DropdownMenuItem(value: Locale('fr'), child: Text("Français")),
            DropdownMenuItem(value: Locale('hi'), child: Text("हिन्दी")),
            DropdownMenuItem(
              value: Locale('zh'),
              child: Text("中文"),
            ), // Chinês Simplificado
            DropdownMenuItem(
              value: Locale('ko'),
              child: Text("한국어"),
            ), // Coreano
            DropdownMenuItem(
              value: Locale('ru'),
              child: Text("Русский"),
            ), // Russo

            DropdownMenuItem(
              value: Locale('ar'),
              child: Text("العربية"),
            ), // Árabe
            DropdownMenuItem(
              value: Locale('he'),
              child: Text("עברית"),
            ), // Hebraico
            DropdownMenuItem(
              value: Locale('fa'),
              child: Text("فارسی"),
            ), // Persa/Farsi
            DropdownMenuItem(
              value: Locale('pl'),
              child: Text("Polski"),
            ), // Polonês
            DropdownMenuItem(
              value: Locale('sr'),
              child: Text("Српски"),
            ), // Sérvio
            DropdownMenuItem(
              value: Locale('ja'),
              child: Text("日本語"),
            ), // Japonês
            DropdownMenuItem(
              value: Locale('sw'),
              child: Text("Kiswahili"),
            ), // Suaíli
            DropdownMenuItem(
              value: Locale('ha'),
              child: Text("Hausa"),
            ), // Hauçá

            DropdownMenuItem(value: Locale('de'), child: Text("Deutsch")),
            DropdownMenuItem(value: Locale('nl'), child: Text("Nederlands")),
          ],
          onChanged: (locale) {
            if (locale != null) {
              langSwitchViewModel.toggle(locale);
            }
          },
        );
      },
    );
  }
}
