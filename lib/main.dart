import 'package:flutter/material.dart';
import 'package:iseneca/presentation/screens/loggin_screen.dart';
import 'package:iseneca/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: const AppTheme().getTheme(),
      home: const LogginScreen(),
    );
  }
}
