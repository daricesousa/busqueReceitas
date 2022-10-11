import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
    primaryColor: AppColor.primary,
  );

    static BoxDecoration boxDecoration({Color? color = AppColor.dark1}) {
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
