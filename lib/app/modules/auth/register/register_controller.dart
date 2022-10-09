import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final editName = TextEditingController();
  final editEmail = TextEditingController();
  final editPass = TextEditingController();
  final editConfirmPass = TextEditingController();
  final form = GlobalKey<FormState>();
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
    if (form.currentState!.validate()) {
      try {
        loading.value = true;
        final res = await repository.register(

          name: editName.text,
          email: editEmail.text,
          password: editPass.text,
        );
        loading.value = false;
        AppSnackBar.success(message: res["message"]);
        Get.toNamed('/login');
      }  on DioError catch  (e) {
        loading.value = false;
        AppSnackBar.error(message: e.response?.data["message"]);
      }
    }
  }
}
