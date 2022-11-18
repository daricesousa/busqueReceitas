import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/utils/image_cached.dart';
import 'package:busque_receitas/app/core/widgets/app_rating.dart';
import 'package:busque_receitas/app/core/widgets/stars.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/recipe/widgets/app_banner.dart';
import 'package:busque_receitas/app/modules/recipe/widgets/cards.dart';
import 'package:busque_receitas/app/modules/recipe/widgets/list_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './recipe_controller.dart';
class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final controller = Get.find<RecipeController>();
  @override
  Widget build(BuildContext context) {
    final recipe = controller.recipe;
    return Scaffold(
      appBar: AppBar(
        // title: Text(recipe.title),
        // centerTitle: true,
        actions: actionsAppBar(),
      ),
      body: Obx(() => body(recipe)),
    );
  }

  Widget body(RecipeModel recipe) {
    return ListView(
      children: [
        AppBanner(
          label: "Ilustrativa",
          // color: AppColor.dark3,
          // labelColor: AppColor.light,
          visible: recipe.pictureIlustration && !controller.pictureError.value,
          child: ImageCached(
            recipe.picture,
            width: Get.width,
            height: Get.height / 3,
            asError: (e) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  controller.pictureError.value = e!= null;
                });
              });
            },
          ),
        ),
        // ImageCached(recipe.picture, width: Get.width, height: Get.height / 3),
        const SizedBox(height: 10),
        Text(
          recipe.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22),
        ),
        cards(
          [
            cardDifficulty(recipe),
            cardAvaliation(recipe),
          ],
        ),
        ...listIngredients(recipe),
        ...listMethods(recipe),
        Obx(() => avaliation(recipe)),
        Center(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(color: AppColor.dark, fontSize: 18),
              text: '${recipe.avaliation.quantity} ',
              children: [
                TextSpan(
                  text: recipe.avaliation.quantity != 1
                      ? 'avaliações'
                      : 'avaliação',
                ),
              ],
            ),
          ),
        ),
        Center(child: Text("criado por ${recipe.creator}")),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  List<Widget> actionsAppBar() {
    return [
      Obx(() => IconButton(
            icon: Icon(
              controller.isFavorite.value
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: AppColor.dark1,
            ),
            onPressed: controller.changeFavorite,
          )),
      Obx(
        () => IconButton(
          icon: Icon(
            controller.isDoLater.value ? Icons.timer : Icons.timer_outlined,
            color: AppColor.dark1,
          ),
          onPressed: controller.changeDoLater,
        ),
      )
    ];
  }

  Widget cardAvaliation(RecipeModel recipe) {
    return cardInfo(Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: Stars.avaliation(
              rating: recipe.avaliation.ratingAverage.toDouble()),
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

  Widget cardDifficulty(RecipeModel recipe) {
    final difficulty = recipe.difficulty.name;
    return cardInfo(
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.bar_chart,
            color: AppColor.dark1,
          ),
          Text(difficulty,
              style: const TextStyle(fontSize: 16, color: AppColor.dark1))
        ],
      ),
    );
  }

  Widget methodWidget({required String method, required int index}) {
    return ListItem(
      // contentPadding: EdgeInsets.zero,
      leading: Text(index.toString()),
      text: method,
    );
  }

  Widget ingredientWidget(RecipeIngredientModel ingredient) {
    final nameIngredient =
        controller.findIngredient(ingredient.ingredientId).name;
    return ListItem(
      leading: controller.havePantry(ingredient.ingredientId)
          ? const Icon(
              Icons.check_box,
              color: AppColor.primary,
            )
          : const Tooltip(
              message: "Você não possui esse ingrediente",
              child: Icon(
                Icons.error,
                color: AppColor.red,
              ),
            ),
      text:
          "${controller.personalizeQuantity(ingredient.quantity)} ${ingredient.measurer} $nameIngredient",
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
                child: Text(
                  "Faça login para avaliar",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: Stars.avaliation(rating: 0),
                ),
              ),
            ],
          ),
        ),
        onTap: () => Get.toNamed('/login'),
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
              child: AppRating(
                initialValue: recipe.avaliation.userRating,
                onTap: (star) {
                  controller.newAvaliation(star);
                },
              )),
        ],
      ),
    );
  }
}
