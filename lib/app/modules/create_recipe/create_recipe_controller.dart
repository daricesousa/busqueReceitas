import 'dart:io';
import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/core/utils/enum_measurer.dart';
import 'package:busque_receitas/app/core/widgets/app_snack_bar.dart';
import 'package:busque_receitas/app/models/groupIngredients_model.dart';
import 'package:busque_receitas/app/models/ingredient_model.dart';
import 'package:busque_receitas/app/modules/create_recipe/ingredient_create_recipe_model.dart';
import 'package:busque_receitas/app/modules/create_recipe/validationCreateRecipe.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:busque_receitas/app/repositories/recipe_repository.dart';
import 'package:whatsapp_camera/whatsapp_camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRecipeController extends GetxController {
  final _listAllIngredients = Get.find<SplashController>().listIngredients;
  final listGroups = Get.find<SplashController>().listGroups;
  List<DropdownMenuItem<String>> listDropMeasurer = [];
  List<DropdownMenuItem<Difficulty>> listDropDifficulty = [];
  List<DropdownMenuItem<String>> listDropTime = [];
  final listIngredientCreate = <IngredientCreateRecipeModel>[].obs;
  final listMethod = <TextEditingController>[].obs;
  final difficulty = Rxn<Difficulty?>();
  final timeSetup = Rxn<String?>();
  final timeCooking = Rxn<String?>();
  final title = TextEditingController();
  final image = Rxn<File?>();
  final errors = <String?>[].obs;
  final pictureIlustration = false.obs;
  final loading = false.obs;
  final aceppetedTerm = false.obs;

  RxList<IngredientModel> get listAllIngredients {
    _listAllIngredients.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return _listAllIngredients;
  }

  @override
  void onInit() {
    _getListDropMeasurer();
    _getListDifficulty();
    _getListDropTime();
    newIngredient();
    newMethod();
    super.onInit();
  }

  void onChangeIngredient(
      {required IngredientModel ingredient, required int index}) {
    listIngredientCreate[index].ingredient = ingredient;
    listIngredientCreate[index] = listIngredientCreate[index];
  }

  void onChangeMeasurer({required String? measurer, required int index}) {
    listIngredientCreate[index].measurer = measurer;
    listIngredientCreate[index] = listIngredientCreate[index];
  }

  void onChangeDifficulty(Difficulty? difficulty) {
    this.difficulty.value = difficulty;
  }

  void onChangeTimeSetup(String? time) {
    timeSetup.value = time;
  }

  void onChangeTimeCooking(String? time) {
    timeCooking.value = time;
  }

  void _getListDropMeasurer() {
    final listMeasurer = Measurer.values.map((e) => e).toList();
    List.generate(listMeasurer.length, (index) {
      final item = DropdownMenuItem<String>(
        value: listMeasurer[index].display,
        child: Text(listMeasurer[index].instrution),
      );
      listDropMeasurer.add(item);
    });
  }

  void _getListDropTime() {
    final listTime = ["até 10 min", "11-30 min", "31-60 min", "mais de 1 hora"];
    List.generate(listTime.length, (index) {
      final item = DropdownMenuItem<String>(
        value: listTime[index],
        child: Text(listTime[index]),
      );
      listDropTime.add(item);
    });
  }

  void _getListDifficulty() {
    final list = Difficulty.values.map((difficulty) {
      return DropdownMenuItem(
        value: difficulty,
        child: Text(difficulty.name),
      );
    }).toList();
    listDropDifficulty.assignAll(list);
  }

  void newIngredient() {
    listIngredientCreate.add(IngredientCreateRecipeModel());
  }

  void removeIngredient(int index) {
    listIngredientCreate.removeAt(index);
  }

  void newMethod() {
    listMethod.add(TextEditingController());
  }

  void removeMethod(int index) {
    listMethod.removeAt(index);
  }

  Future<void> getImage(BuildContext context) async {
    List<File>? res =
        await Get.to<List<File>>(const WhatsappCamera(multiple: true));
    if (res != null && res.isNotEmpty) {
      image.value = res[0];
    }
  }

  void createIngredient({
    required String ingredientName,
    required GroupIngredientsModel group,
    required int index,
  }) {
    Get.back();
    final ingredient = IngredientModel(
        id: -1, name: ingredientName, groupId: group.id, associates: []);
    _listAllIngredients.add(ingredient);
    onChangeIngredient(ingredient: ingredient, index: index);
  }

  void validations() {
    errors.assignAll([
      ValidationCreateRecipe.title(title.text),
      ValidationCreateRecipe.difficulty(difficulty.value),
      ValidationCreateRecipe.image(image.value),
      ValidationCreateRecipe.listIngredient(listIngredientCreate),
      ValidationCreateRecipe.method(listMethod),
      ValidationCreateRecipe.timeSetup(timeSetup.value),
      ValidationCreateRecipe.timeCooking(timeCooking.value),
    ]);

    String? ingredientErro;
    for (var index = 0;
        index < listIngredientCreate.length && ingredientErro == null;
        index += 1) {
      ingredientErro = ValidationCreateRecipe.ingredient(
          listIngredientCreate[index].ingredient);

      if (ingredientErro == null) {
        final nameIngredient = listIngredientCreate[index].ingredient!.name;
        ingredientErro = ValidationCreateRecipe.quantity(
          quantity: listIngredientCreate[index].quantity.text,
          nameIngredient: nameIngredient,
        );

        ingredientErro = ingredientErro ??
            ValidationCreateRecipe.measurer(
              measurer: listIngredientCreate[index].measurer,
              nameIngredient: nameIngredient,
            );
      }
    }
    errors.add(ingredientErro);

    if (!aceppetedTerm.value) {
      errors.add("É preciso aceitar os Termos");
    }

    errors.removeWhere((e) => e == null);

    if (errors.isEmpty) _create();
  }

  _create() async {
    final ingredients = listIngredientCreate.map((e) => e.toMap()).toList();
    final method = listMethod.map((e) => e.text).toList();
    final repository = RecipeRepository();
    try {
      loading.value = true;
      final data = await repository.createRecipe(
          title: title.text,
          ingredients: ingredients,
          method: method,
          picturePath: image.value!.path,
          pictureIlustration: pictureIlustration.value,
          difficulty: difficulty.value!.index,
          timeSetup: timeSetup.value!,
          timeCooking: timeCooking.value!);
      loading.value = false;
      Get.back();
      AppSnackBar.success(message: data["message"]);
    } on DioError catch (e) {
      loading.value = false;
      try {
        AppSnackBar.error(message: e.response?.data["message"]);
      } catch (e) {
        AppSnackBar.error(message: "Erro de conexão");
      }
    }
  }
}
