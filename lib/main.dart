import 'package:chess_versus/src/data/repositories/theme/theme_repository.dart';
import 'package:flutter/material.dart';
import 'src/app_widget.dart';
import 'src/data/services/theme_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppWidget(themeRepository: ThemeRepository(ThemeService())));
}
