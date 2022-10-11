import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:flutter/material.dart';

class Stars {
  Stars._();

  static List<Widget> avaliation(
      {required double rating, Color? color = AppColor.dark1, int size = 15}) {
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

  static List<Widget> filter(
      {required int quantity, Color? color = AppColor.light}) {
    return List.generate(quantity + 1, (index) {
      if (index != quantity) {
        return Icon(Icons.star, color: color, size: 15);
      } else if(quantity!= 5 ){
        return Text(" e acima", style: TextStyle(color: color, fontSize: 15),);
      }
      return Container();
    });
  }
}
