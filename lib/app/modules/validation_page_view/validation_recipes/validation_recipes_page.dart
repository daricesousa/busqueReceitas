import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/utils/image_cached.dart';
import 'package:busque_receitas/app/core/widgets/no_results_page.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './validation_recipes_controller.dart';

class ValidationRecipesPage extends GetView<ValidationRecipesController> {
  const ValidationRecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Receitas para validação',
            style: TextStyle(fontSize: 18),
          ),
          centerTitle: true),
      body: Obx(body),
    );
  }

  Widget body() {
    if (!controller.loading.value && controller.listRecipes.isEmpty) {
      return NoResultsPage(
        title: "Nada para validar",
        subtitle: "Ver receitas",
        onPressed: Get.back,
      );
    }
    if (controller.loading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.builder(
        itemCount: controller.listRecipes.length,
        itemBuilder: ((context, index) {
          print(index);
          final recipe = controller.listRecipes[index];
          return widgetRecipe(recipe, context);
        }));
  }

  Widget widgetRecipe(RecipeModel recipe, BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Card(
            child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(padding: const EdgeInsets.only(left: 10, top: 10),
                child: ImageCached(recipe.picture, width: context.width / 5 * 2),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          recipe.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, color: AppColor.dark),
                        ),
                        
                        Text(
                          "criado por ${recipe.creator}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15, color: AppColor.dark2),
                        ),
                      ]),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    onPressed: () => controller.validateRecipe(
                        recipe: recipe, accept: true)),
                IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () => controller.validateRecipe(
                        recipe: recipe, accept: false)),
              ],
            )
          ],
        )),
      ),
      onTap: () => controller.goPageRecipe(recipe),
    );
  }
}
