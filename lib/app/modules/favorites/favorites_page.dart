import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/utils/image_convert.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './favorites_controller.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: body(),
    );
  }

  Widget body() {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, mainAxisExtent: 140),
        itemCount: controller.listFavorites.length,
        itemBuilder: ((context, index) {
          final recipe = controller.listFavorites[index];
          return widgetRecipe(recipe, context);
        }));
  }

  Widget widgetRecipe(RecipeModel recipe, BuildContext context) {
    int missedIngredients =
        controller.missedIngredients(recipe.listIngredients);
    String textMissed = '';
    if (missedIngredients == 1) {
      textMissed = "Falta 1 ingrediente";
    } else if (missedIngredients > 1) {
      textMissed = "Faltam $missedIngredients ingredientes";
    }
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: ImageConvert.base64fromImage(
                    base64String: recipe.picture, height: context.height),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      recipe.title,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      textMissed,
                      style: const TextStyle(
                          fontSize: 15, color: AppTheme.colorRed),
                    ),
                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: IconButton(
                    //       onPressed: () {}, icon: Icon(Icons.delete)),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        controller.goPageRecipe(recipe);
      },
    );
  }
}