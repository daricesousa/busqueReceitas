import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:flutter/material.dart';

class Stars {
  Stars._();

  static List<Widget> stars(
      {required double rating, Color? color = AppColor.dark1}) {
    List<Widget> list = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        list.add(Icon(
          Icons.star,
          color: color,
        ));
      } else if (i - rating <= 0.5) {
        list.add(Icon(
          Icons.star_half,
          color: color,
        ));
      } else {
        list.add(Icon(
          Icons.star_border,
          color: color,
        ));
      }
    }
    return list;
  }
}
