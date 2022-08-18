import 'dart:io';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ConnectBinding implements Bindings {
  @override
  void dependencies() {
    const baseUrl =
        "https://6fca-2804-ad8-c008-1c00-5b5a-c99c-56d9-960c.ngrok.io";
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
