import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final _user = Get.find<SplashController>().user;

  String get userName{
    return _user.value!.name;
  }

  String get userEmail{
    return _user.value!.email;
  }

  void logoutUser() {
    Get.back();
    Get.find<SplashController>().user.value = null;
    GetStorage().remove('user');
    Get.find<Dio>().options.headers = {};
    AppSnackBar.success(message: "Usuário deslogado");
  }



}