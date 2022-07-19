import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
    primaryColor: Colors.purpleAccent,
  );
}
