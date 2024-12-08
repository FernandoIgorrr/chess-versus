import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'src/app_widget.dart';
import 'src/config/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(MultiProvider(providers: providersLocal, child: AppWidget()));
}
