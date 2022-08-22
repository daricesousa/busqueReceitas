import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/utils/image_convert.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './recipe_controller.dart';

class RecipePage extends GetView<RecipeController> {
  const RecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipe = controller.recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        centerTitle: true,
        actions: actionsAppBar(),
      ),
      body: body(recipe),
    );
  }

  Widget body(RecipeModel recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageConvert.base64fromImage(
            base64String: recipe.picture,
            width: Get.width,
            height: Get.height / 3),
        cards(recipe),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Ingredientes:",
            style: TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: recipe.listIngredients.length,
              itemBuilder: ((context, index) {
                final ingredient = recipe.listIngredients[index];
                final nameIngredient =
                    controller.nameIngredient(ingredient.ingredientId);
                return ListTile(
                  leading: controller.splashController
                          .havePatry(ingredient.ingredientId)
                      ? const Icon(
                          Icons.check_box,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                  title: Text(
                      "${ingredient.quantity} ${ingredient.measurer} $nameIngredient"),
                );
              })),
        )
      ],
    );
  }

  List<Widget> actionsAppBar() {
    return const [
      Icon(Icons.favorite),
      Padding(
        padding: EdgeInsets.all(15.0),
        child: Icon(Icons.timer),
      ),
    ];
  }

  Widget cardInfo(Widget child) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: AppTheme.boxDecoration(color: Colors.green),
      child: child,
    );
  }

  Widget cards(RecipeModel recipe) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.center,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: cardInfo(Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bar_chart),
                    Text('Dificuldade: ${recipe.difficulty}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white))
                  ],
                )),
              ),
              cardInfo(Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Text('127 avaliações',
                      style: TextStyle(fontSize: 18, color: Colors.white))
                ],
              ))
            ],
          ),
        ));
  }
}
