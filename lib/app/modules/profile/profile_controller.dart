import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final _user = Get.find<SplashController>().user;

  String get userName{
    return _user.value!.name;
  }



}