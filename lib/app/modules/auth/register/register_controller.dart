import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final editName = TextEditingController();
  final editEmail = TextEditingController();
  final editPass = TextEditingController();
  final editConfirmPass = TextEditingController();

  final loading = false.obs;
  final repository = AuthRepository();

  @override
  void onClose() {
    editName.dispose();
    editEmail.dispose();
    editPass.dispose();
    editConfirmPass.dispose();
    super.onClose();
  }

  Future<void> createUser() async {
    try {
      loading.value = true;
      final res = await repository.register(
        name: editName.text,
        email: editEmail.text,
        password: editPass.text,
      );
      AppSnackBar.success(message: res["message"]);
      final user = await repository.sign(
        email: editEmail.text,
        password: editPass.text,
      );
      Get.find<SplashController>().user.value = user;
      loading.value = false;
      Get.toNamed('/layout');
    } on DioError catch (e) {
      loading.value = false;
      AppSnackBar.error(message: e.response?.data["message"]);
    }
  }
}
