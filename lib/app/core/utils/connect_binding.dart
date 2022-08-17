import 'dart:io';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ConnectBinding implements Bindings {
  @override
  void dependencies() {
    const baseUrl =
        "https://bd4a-200-137-174-178.ngrok.io";
    Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
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
