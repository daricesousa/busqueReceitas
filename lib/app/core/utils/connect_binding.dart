import 'dart:io';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ConnectBinding implements Bindings {
  @override
  void dependencies() {
    // const baseUrl = "https://busque-receitas.onrender.com";
    const baseUrl = "https://ecc6-2804-5fb8-c018-bb00-427f-9d38-dd7-27aa.ngrok.io";
    final user = GetStorage().read('user') as Map?;
    Map<String, dynamic> headers = {};
    if (user != null) {
      headers = {"Authorization": "Bearer ${user['token']}"};
    }
    Dio dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
    ));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    Get.put(dio);
    Get.put(SplashController());
  }
}
