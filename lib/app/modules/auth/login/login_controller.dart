import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

final form = GlobalKey<FormState>();
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

  Future<void> login() async{
    if (form.currentState!.validate()) {
      try {
        loading.value = true;
        final res = await repository.sign(
          email: editEmail.text,
          password: editPass.text,
        );
        loading.value = false;
        AppSnackBar.success(res["message"]);
        Get.toNamed('/');
      }
      on DioError catch(e){
        loading.value = false;
        AppSnackBar.error(e.response?.data["message"]);
      }
    }
  }

}