import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/app_widget.dart';
import 'src/config/dependencies.dart';

void main() {
  runApp(MultiProvider(providers: providersLocal, child: AppWidget()));
}
