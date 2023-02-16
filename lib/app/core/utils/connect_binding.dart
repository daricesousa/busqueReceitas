import 'dart:io';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ConnectBinding implements Bindings {
  @override
  void dependencies() {
    const baseUrl = "http://ec2-3-209-11-224.compute-1.amazonaws.com/";
    final user = GetStorage().read('user') as Map?;
    Map<String, dynamic> headers = {};
    if (user != null) {
      headers = {"Authorization": "Bearer ${user['token']}"};
    }
    Dio dio = Dio(BaseOptions(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      baseUrl: baseUrl,
      headers: headers,
    ));
    
    Get.put(dio);
    Get.put(SplashController());
  }
}
