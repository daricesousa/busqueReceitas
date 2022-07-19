import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppSnackBar {
   static success(String? message) {
    Get.snackbar("Sucesso", message ?? "",
        colorText: Get.theme.secondaryHeaderColor,
        backgroundColor: Get.theme.primaryColor,
        boxShadows: [const BoxShadow(blurRadius: 10)]);
  }

  static error(String? message) {
    Get.snackbar("Ops!", message ?? "Algo deu errado",
        colorText: Get.theme.secondaryHeaderColor,
        backgroundColor: Get.theme.errorColor,
        boxShadows: [const BoxShadow(blurRadius: 10)]);
  }
}
