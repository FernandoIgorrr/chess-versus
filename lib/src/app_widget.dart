import 'package:chess_versus/src/routing/router.dart';
import 'package:chess_versus/src/ui/core/themes/view_models/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'ui/core/themes/theme.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final themeViewModel = ThemeViewModel.getInstance();

  @override
  Widget build(BuildContext context) {
    final appRouter = router();

    return ListenableBuilder(
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Chess versus',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) return const Locale('en');

            // for (var supportedLocale in supportedLocales) {
            //   if (supportedLocale.languageCode == locale.languageCode) {
            //     return supportedLocale;
            //   }
            // }
            return const Locale('en');
          },
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeViewModel.themeMode,
          routerConfig: appRouter,
        );
      },
      listenable: themeViewModel,
    );
  }
}
