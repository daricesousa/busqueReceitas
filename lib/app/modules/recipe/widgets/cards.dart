import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:flutter/material.dart';

Widget cardInfo(Widget child) {
  return Theme(
    data: AppTheme.theme,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: AppTheme.boxDecoration(color: AppColor.light2),
      child: child,
    ),
  );
}

Widget cards(List<Widget> children) {
  return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.center,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.spaceEvenly,
          children: children,
        ),
      ));
}
