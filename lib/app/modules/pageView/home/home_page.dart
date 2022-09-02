import 'package:busque_receitas/app/core/utils/image_convert.dart';
import 'package:busque_receitas/app/core/widgets/erro_page.dart';
import 'package:busque_receitas/app/core/widgets/stars.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
import 'package:busque_receitas/app/modules/pageView/home/widgets/app_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
      ),
      body: Obx(() => body()),
      drawer: Obx(() => AppDrawer(
          logoutUser: controller.logoutUser, user: controller.user.value)),
    );
  }

  Widget body() {
    if (!controller.visibleRefrash.value && controller.listRecipes.isEmpty) {
      return ErroPage(
          visible: controller.visibleRefrash.value,
          onPressed: () async {
            await controller.getRecipes();
          });
    }
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent: 220),
        itemCount: controller.listRecipes.length,
        itemBuilder: ((context, index) {
          final recipe = controller.listRecipes[index];
          return widgetRecipe(recipe, context);
        }));
  }

  Widget widgetRecipe(RecipeModel recipe, BuildContext context) {
    int missedIngredients = controller.missedIngredients(recipe.listIngredients);
    return GestureDetector(
      child: Card(
        color: Colors.amber,
        child: Column(
          children: [
            ImageConvert.base64fromImage(
                base64String: recipe.picture, width: context.width / 2.1),
            Container(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  recipe.title,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  missedIngredients == 0 ? "" : "${missedIngredients} ingredientes faltando",
                  style: const TextStyle(fontSize: 15),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: Stars.stars(rating: recipe.rating))
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        controller.goPageRecipe(recipe);
      },
    );
  }
}
