import 'package:busque_receitas/app/core/utils/image_convert.dart';
import 'package:busque_receitas/app/core/widgets/app_form_field.dart';
import 'package:busque_receitas/app/core/widgets/erro_page.dart';
import 'package:busque_receitas/app/core/widgets/stars.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/filter_recipe/filter_recipe_controller.dart';
import 'package:busque_receitas/app/modules/pageView/home/filter_recipe/filter_recipe_page.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
import 'package:busque_receitas/app/modules/pageView/home/widgets/app_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
        bottom: PreferredSize(
          preferredSize: Size(context.width, 100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppFormField(
              onChanged: (word) {
                controller.search.value = word;
              },
              label: "Pesquise aqui",
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.put(FilterRecipeController());
                SideSheet.right(body: FilterRecipePage(), context: context);
              },
              icon: const Icon(Icons.filter_list_alt))
        ],
      ),
      body: Obx(() => body()),
      drawer: Obx(() => AppDrawer(
          logoutUser: controller.logoutUser, user: controller.user.value)),
    );
  }

  Widget body() {
    if (!controller.visibleRefrash.value &&
        controller.listRecipes.isEmpty &&
        controller.search.value == '' &&
        controller.listFilters.isEmpty) {
      return ErroPage(
          visible: controller.visibleRefrash.value,
          onPressed: () async {
            await controller.getRecipes();
          });
    }
   
    return Column(
      children: [
        // Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 10),
        //     height: 60,
        //     child: ListView(
        //          scrollDirection: Axis.horizontal,
        //       children: [
        //         cardFilter(text: "Ingrediente chave", action: (){}),
        //         cardFilter(text: "Dificuldade", action: (){}),
        //         cardFilter(text: "Avaliação", action: (){}),
        //       ],
        //     )),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 220),
              itemCount: controller.listRecipes.length,
              itemBuilder: ((context, index) {
                final recipe = controller.listRecipes[index];
                return widgetRecipe(recipe, context);
              })),
        ),
      ],
    );
  }

  Widget widgetRecipe(RecipeModel recipe, BuildContext context) {
    int missedIngredients =
        controller.missedIngredients(recipe.listIngredients);
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
                  missedIngredients == 0
                      ? ""
                      : "$missedIngredients ingredientes faltando",
                  style: const TextStyle(fontSize: 15),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        Stars.stars(rating: recipe.avaliation.ratingAverage))
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

  Widget cardFilter({required String text, required void Function()? action}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
              onPressed: action,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              )),
        ));
  }
}
