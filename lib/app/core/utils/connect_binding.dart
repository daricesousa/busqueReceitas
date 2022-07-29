import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ConnectBinding implements Bindings {
  @override
  void dependencies() {
    const baseUrl =
        "https://304c-2804-ad8-c004-6300-857c-f6d8-f1b6-d20d.ngrok.io";
    Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    Get.put(dio);
  }
}
