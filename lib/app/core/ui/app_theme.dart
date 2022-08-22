import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
    primaryColor: Colors.purpleAccent,
  );

    static BoxDecoration boxDecoration({Color color = Colors.green}) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            offset: Offset(1, 1),
          )
        ]);
  }
}
