import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final editEmail = TextEditingController();
  final editPass = TextEditingController();
  final loading = false.obs;
  final repository = AuthRepository();

  @override
  void onClose() {
    editEmail.dispose();
    editPass.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      loading.value = true;
      final user = await repository.sign(
        email: editEmail.text,
        password: editPass.text,
      );
      loading.value = false;
      Get.back();
      AppSnackBar.success(message: "Login efetuado");
      Get.find<SplashController>().user.value = user;
      // Get.offNamedUntil('/', (route) => false);
    } on DioError catch (e) {
      loading.value = false;
      AppSnackBar.error(message: e.response?.data?["message"]);
    }
  }
}
