import 'package:busque_receitas/app/core/utils/enumDifficulty.dart';
import 'package:busque_receitas/app/core/utils/image_convert.dart';
import 'package:busque_receitas/app/core/widgets/app_rating.dart';
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
    return ListView(
      children: [
        image(recipe),
        cards(
          [
            cardDifficulty(recipe),
            cardAvaliation(recipe),
          ],
        ),
        ...listIngredients(recipe),
        ...listMethods(recipe),
        Obx(() => avaliation(recipe)),
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
          children: Stars.stars(rating: recipe.avaliation.ratingAverage.toDouble()),
        ),
        Text.rich(
          TextSpan(
            style: const TextStyle(color: Colors.white, fontSize: 16),
            text: '${recipe.avaliation.quantity} ',
            children: [
              TextSpan(
                text:
                    recipe.avaliation.quantity != 1 ? 'avaliações' : 'avaliação',
              ),
            ],
          ),
        ),
      ],
    ));
  }

  List<Widget> listIngredients(RecipeModel recipe) {
    return [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Ingredientes:",
          style: TextStyle(fontSize: 20, color: Colors.green),
          textAlign: TextAlign.start,
        ),
      ),
      ...recipe.listIngredients.map((e) => ListTile(title: ingredientWidget(e)))
    ];
  }

  List<Widget> listMethods(RecipeModel recipe) {
    int index = 0;
    return [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "Modo de preparo:",
          style: TextStyle(fontSize: 20, color: Colors.green),
          textAlign: TextAlign.start,
        ),
      ),
      ...recipe.method.map((e) {
        index++;
        return ListTile(title: methodWidget(method: e, index: index));
      })
    ];
  }

  Widget cardDifficulty(RecipeModel recipe) {
    final difficulty = DifficultyConvert.diffilcultyToString(recipe.difficulty);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: cardInfo(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bar_chart),
          Text('Dificuldade: $difficulty',
              style: const TextStyle(fontSize: 18, color: Colors.white))
        ],
      )),
    );
  }

  Widget methodWidget({required String method, required int index}) {
    return ListTile(
      leading: Text(index.toString()),
      title: Text(method),
    );
  }

  Widget ingredientWidget(RecipeIngredientModel ingredient) {
    final nameIngredient = controller.findIngredient(ingredient.ingredientId).name;
    return ListTile(
      leading: controller.havePatry(ingredient.ingredientId)
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
    if (controller.user.value == null) {
      return ListTile(
        title: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Faça login para avaliar", style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.normal),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: Stars.stars(rating: 0, color: Colors.green),
                ),
              ),
            ],
          ),
        ),
        onTap: () => Get.toNamed('\login'),
      );
    }
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Avalie aqui:"),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: AppRating(initialValue: recipe.avaliation.userRating, onTap: (star){
              controller.newAvaliation(star);
            },)
          ),
        ],
      ),
    );
  }
}
