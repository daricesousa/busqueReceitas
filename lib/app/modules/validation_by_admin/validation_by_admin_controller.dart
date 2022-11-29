import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/ingredient_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ValidationByAdminController extends GetxController {
  final listIngredients = <IngredientModel>[].obs;
  final _listGroups = Get.find<SplashController>().listGroups;
  final _repositoryIngredient = IngredientRepository();
  final loading = false.obs;

  @override
  void onInit() async {
    await _getIngredients();
    super.onInit();
  }

  Future<void> _getIngredients() async {
    loading.value = true;
    try {
      listIngredients.assignAll(
          await _repositoryIngredient.getIngredients(show: 'invalid'));
      loading.value = false;
    } catch (e) {
      print(e);
      loading.value = false;
    }
  }

  Future<void> validateIngredient(
      {required IngredientModel ingredient, required bool accept}) async {
    try {
      final data = await _repositoryIngredient.validateIngredient(
          id: ingredient.id, accept: accept);
      AppSnackBar.success(message: data["message"]);
      listIngredients.remove(ingredient);
    } on DioError catch (e) {
      print(e);
      AppSnackBar.success(message: e.response?.data["message"]);
    }
  }

  String? nameGroup(int groupId) {
    final index = _listGroups.indexWhere((g) => g.id == groupId);
    if (index > -1) {
      return _listGroups[index].name;
    }
  }
}
