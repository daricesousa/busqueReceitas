import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/utils/image_cached.dart';
import 'package:busque_receitas/app/core/utils/timer_convert.dart';
import 'package:busque_receitas/app/core/widgets/app_rating.dart';
import 'package:busque_receitas/app/core/widgets/stars.dart';
import 'package:busque_receitas/app/models/recipe/recipe_ingredient_model.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/recipe/widgets/app_banner.dart';
import 'package:busque_receitas/app/modules/recipe/widgets/list_item.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
          visible: recipe.pictureIlustration && !controller.pictureError.value,
          child: ImageCached(
            recipe.picture,
            width: Get.width,
            height: Get.height / 3,
            asError: (e) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  controller.pictureError.value = e != null;
                });
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
            Expanded(
                child: ListItem(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: Stars.avaliation(
                    rating: recipe.avaliation.ratingAverage.toDouble()),
              ),
            )),
          ],
        ),
        const SizedBox(height: 30),
        ...listIngredients(recipe),
        const SizedBox(height: 30),
        ...listMethods(recipe),
        const SizedBox(height: 30),
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
      Obx(() => Tooltip(
          message: "Adicione a receita aos favoritos para encontrá-la mais fácil",
          child: IconButton(
            icon: Icon(
              controller.isFavorite.value
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: AppColor.dark1,
            ),
            onPressed: controller.changeFavorite,
          ))),
      Obx(() => Tooltip(
        message: "Faça essa receita mais tarde. Os ingredientes da receita que não tiverem na despensa serão adicionados à lista de compras.",
            child: IconButton(
              icon: Icon(
                controller.isDoLater.value ? Icons.timer : Icons.timer_outlined,
                color: AppColor.dark1,
              ),
              onPressed: controller.changeDoLater,
            ),
          ))
    ];
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
