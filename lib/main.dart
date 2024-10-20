import 'package:financiera_milenians_app/presentation/screen/screens.dart';
import 'package:flutter/material.dart';

import 'package:financiera_milenians_app/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const MainScreen(),
    );
  }
}