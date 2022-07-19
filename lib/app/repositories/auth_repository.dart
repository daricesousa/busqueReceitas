import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthRepository {
  final _api = Get.find<Dio>();

  Future<Map> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await _api.post("/register", data: {
      "name": name,
      "email": email,
      "password": password,
    });
    return res.data;
  }

  Future<Map> sign({
    required String email,
    required String password,
  }) async {
    final res = await _api.post("/sign", data: {
      "email": email,
      "password": password,
    });
    return res.data;
  }
}
