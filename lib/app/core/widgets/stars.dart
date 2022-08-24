import 'package:flutter/material.dart';

class Stars{
  Stars._();

  static List<Widget> stars(double rating) {
    List<Widget> list = [];
    for (int i = 1; i <= 5; i++) {
      if (i <= rating) {
        list.add(const Icon(
          Icons.star,
          color: Colors.white,
        ));
      }
      else if(i - rating <= 0.5){
        list.add(const Icon(
          Icons.star_half,
          color: Colors.white,
        ));
      }
      else{
        list.add(const Icon(
          Icons.star_border,
          color: Colors.white,
        ));
      }
    }
    return list;
  }
}


