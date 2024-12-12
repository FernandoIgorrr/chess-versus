import 'package:chess_versus/src/data/repositories/theme/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'src/app_widget.dart';
import 'src/data/services/theme_service.dart';

void main() {
  Logger.root.level = Level.ALL;
  final Logger log = Logger('MyApp');
  log.info('App started');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppWidget(themeRepository: ThemeRepository(ThemeService())));
}
