import 'package:chess_versus/src/config/dependencies.dart';
import 'package:chess_versus/src/routing/router.dart';
import 'package:chess_versus/src/ui/core/theme_config/view_models/theme_switch_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'app_widget_view_model.dart';
import 'data/repositories/theme/theme_repository.dart';
import 'ui/core/theme_config/theme.dart';

class AppWidget extends StatefulWidget {
  final ThemeRepository themeRepository;
  const AppWidget({super.key, required this.themeRepository});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late AppWidgetViewModel _viewModel;
  late List<SingleChildWidget> providers;

  @override
  void initState() {
    super.initState();
    _viewModel = AppWidgetViewModel(widget.themeRepository);
    providers = [
      ...providersLocal,
      ChangeNotifierProvider(
          create: (_) => ThemeSwitchViewModel(widget.themeRepository))
    ];
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  //runApp(MultiProvider(providers: providersLocal, child: AppWidget()));

  @override
  Widget build(BuildContext context) {
    final appRouter = router();
    //themeProvider.loadTheme();
    return MultiProvider(
      providers: providers,
      child: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Chess versus',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale == null) return const Locale('en');

              /*for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }*/
              return const Locale('en');
            },
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: _viewModel.state.themeMode,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
