import 'package:busque_receitas/app/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  Future<UserModel> sign({
    required String email,
    required String password,
  }) async {
    final res = await _api.post("/sign", data: {
      "email": email,
      "password": password,
    });
    final  user = UserModel.fromMap(res.data);
    await GetStorage().write('user', res.data);
    _api.options.headers = {
      "Authorization": "Bearer ${res.data['token']}"
    };
    return user;
  }


}
