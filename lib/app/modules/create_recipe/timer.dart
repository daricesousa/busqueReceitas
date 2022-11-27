import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_pickerr/time_pickerr.dart';

class TimerApp{
   static Widget buildCustomTimer(BuildContext context) {
    return CustomHourPicker(
      
      elevation: 2,
      onPositivePressed: (context, time) {
        print('onPositive');
      },
      onNegativePressed: (context) {
        Get.back();
      },
    );
  }
}
