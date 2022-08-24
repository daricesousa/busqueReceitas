import 'package:busque_receitas/app/core/utils/image_convert.dart';
import 'package:busque_receitas/app/core/widgets/stars.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/recipe/widgets.dart';
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
        image(recipe),
        cards(
          [
            cardDifficulty(recipe),
            cardAvaliation(recipe),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Ingredientes:",
            style: TextStyle(fontSize: 20, color: Colors.green),
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: recipe.listIngredients.length,
              itemBuilder: ((context, index) {
                final ingredient = recipe.listIngredients[index];
                return ingredientWidget(ingredient);
              })),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Modo de preparo:",
            style: TextStyle(fontSize: 20, color: Colors.green),
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: recipe.method.length,
              itemBuilder: ((context, index) {
                final method = recipe.method[index];
                return methodWidget(index: index, method: method);
              })),
        ),
        avaliation(recipe),
      ],
    );
  }

  Widget image(RecipeModel recipe) {
    return ImageConvert.base64fromImage(
        base64String: recipe.picture, width: Get.width, height: Get.height / 3);
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

  Widget cardAvaliation(RecipeModel recipe) {
    return cardInfo(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: Stars.stars(recipe.rating),
        ),
        Text('${recipe.avaliations.length} avaliações',
            style: const TextStyle(fontSize: 18, color: Colors.white))
      ],
    ));
  }

  

  Widget cardDifficulty(RecipeModel recipe) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: cardInfo(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bar_chart),
          Text('Dificuldade: ${recipe.difficulty}',
              style: const TextStyle(fontSize: 18, color: Colors.white))
        ],
      )),
    );
  }

  Widget methodWidget({required String method, required int index}) {
    final step = index + 1;
    return ListTile(
      leading: Text(step.toString()),
      title: Text(method),
    );
  }

  Widget ingredientWidget(RecipeIngredientModel ingredient) {
    final nameIngredient = controller.nameIngredient(ingredient.ingredientId);
    return ListTile(
      leading: controller.splashController.havePatry(ingredient.ingredientId)
          ? const Icon(
              Icons.check_box,
              color: Colors.green,
            )
          : const Icon(
              Icons.error,
              color: Colors.red,
            ),
      title:
          Text("${ingredient.quantity} ${ingredient.measurer} $nameIngredient"),
    );
  }

  Widget avaliation(RecipeModel recipe) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: [
            const Text("Avalie aqui"),
            Row(
              children: Stars.stars(0),
            )
          ],
        ),
      ),
    );
  }
}
