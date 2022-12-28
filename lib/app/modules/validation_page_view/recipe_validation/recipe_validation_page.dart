import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/utils/image_cached.dart';
import 'package:busque_receitas/app/core/utils/timer_convert.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/recipe/widgets/app_banner.dart';
import 'package:busque_receitas/app/modules/recipe/widgets/list_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './recipe_validation_controller.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';

class RecipeValidationPage extends GetView<RecipeValidationController> {
  const RecipeValidationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipe = controller.recipe;
    return Scaffold(
      appBar: AppBar(title: Text("Valide a receita"), centerTitle: true),
      body: Obx(() => body(recipe, context)),
    );
  }

  Widget body(RecipeModel recipe, BuildContext context) {
    return ListView(
      children: [
        AppBanner(
          label: "Ilustrativa",
          visible: recipe.pictureIlustration && !controller.pictureError.value,
          child: ImageCached(
            recipe.picture,
            width: Get.width,
            height: Get.height / 3,
            asError: (e) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                controller.pictureError.value = e != null;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Text(
          recipe.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: context.width / 2,
              child: ListItem(
                leading: const Icon(MdiIcons.chefHat, color: AppColor.primary),
                text: "Preparo: ${TimerConvert.forString(recipe.timeSetup)}",
              ),
            ),
            Expanded(
              child: ListItem(
                  leading: const Icon(Icons.bar_chart, color: AppColor.primary),
                  text: "Esforço: ${recipe.difficulty.name}"),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: context.width / 2,
              child: ListItem(
                  leading:
                      const Icon(MdiIcons.gasBurner, color: AppColor.primary),
                  text:
                      "Cozimento: ${TimerConvert.forString(recipe.timeCooking)}"),
            ),
          ],
        ),
        const SizedBox(height: 30),
        ...listIngredients(recipe),
        const SizedBox(height: 30),
        ...listMethods(recipe),
        const SizedBox(height: 30),
        Center(child: Text("criado por ${recipe.creator}")),
        const SizedBox(height: 30),
        validate(recipe),
        const SizedBox(height: 20),
      ],
    );
  }

  List<Widget> listIngredients(RecipeModel recipe) {
    return [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Ingredientes:",
          style: TextStyle(fontSize: 20, color: AppColor.dark1),
          textAlign: TextAlign.start,
        ),
      ),
      ...recipe.listIngredients.map((e) => ingredientWidget(e))
    ];
  }

  List<Widget> listMethods(RecipeModel recipe) {
    return [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Modo de preparo:",
          style: TextStyle(fontSize: 20, color: AppColor.dark1),
          textAlign: TextAlign.start,
        ),
      ),
      ...List.generate(recipe.method.length, (index) {
        return methodWidget(method: recipe.method[index], index: index + 1);
      })
    ];
  }

  Widget methodWidget({required String method, required int index}) {
    return ListItem(
      leading: Text(index.toString()),
      text: method,
    );
  }

  Widget ingredientWidget(RecipeIngredientModel ingredient) {
    final nameIngredient =
        controller.findIngredient(ingredient.ingredientId).name;
    return ListItem(
      leading: controller.validate(ingredient.ingredientId)
          ? const Icon(
              Icons.circle,
              color: AppColor.primary,
              size: 15,
            )
          : const Tooltip(
              message: "Ingrediente não validado",
              child: Icon(
                Icons.circle,
                color: AppColor.red,
                size: 15,
              ),
            ),
      text:
          "${controller.personalizeQuantity(ingredient.quantity)} ${ingredient.measurer} $nameIngredient",
    );
  }

  Widget validate(RecipeModel recipe) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      IconButton(
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          onPressed: () {
            controller.validateRecipe(accept: true, recipe: recipe);
            Get.back();
          }),
      IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.red,
          ),
          onPressed: () {
            controller.validateRecipe(accept: false, recipe: recipe);
            Get.back();
          }),
    ]);
  }
}
