import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/utils/image_cached.dart';
import 'package:busque_receitas/app/core/widgets/app_form_field.dart';
import 'package:busque_receitas/app/core/widgets/erro_page.dart';
import 'package:busque_receitas/app/core/widgets/no_results_page.dart';
import 'package:busque_receitas/app/core/widgets/stars.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/filter_recipe/filter_recipe_controller.dart';
import 'package:busque_receitas/app/modules/pageView/home/filter_recipe/filter_recipe_page.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
import 'package:busque_receitas/app/modules/pageView/home/widgets/app_drawer.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
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
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(context.width, 100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppFormField(
              controller: controller.searchController,
              textInputAction: TextInputAction.search,
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
              SideSheet.right(
                width: context.width / 5 * 4,
                body: const FilterRecipePage(),
                context: context,
              );
            },
            icon: const Icon(Icons.filter_list_alt),
            color: AppColor.dark1,
          )
        ],
      ),
      body: Obx(() => body(context)),
      drawer: Obx(() => AppDrawer(user: controller.user.value)),
    );
  }

  Widget body(BuildContext context) {
    if (controller.visibleRefrash.value || controller.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColor.dark2,
        ),
      );
    }
    if (!controller.visibleRefrash.value &&
        controller.listRecipes.isEmpty &&
        controller.search.value == '' &&
        controller.listFilters.isEmpty) {
      return ErroPage(
          visible: controller.visibleRefrash.value,
          onPressed: () {
            controller.getRecipes();
          });
    }
    if (!controller.visibleRefrash.value && controller.listRecipes.isEmpty) {
      return Column(
        children: [
          listFilters(),
          const SizedBox(height: 10),
          Expanded(
              child: NoResultsPage(
            visible: controller.visibleRefrash.value,
            title: "Nenhuma receita encontrada",
            subtitle: "Limpar filtros",
            onPressed: () => controller.clearFilters(),
          ))
        ],
      );
    }
    return Column(
      children: [
        if (controller.listFilters.isNotEmpty) listFilters(),
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 245),
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
    int missedIngredientsQuant =
        controller.missedIngredientsQuant(recipe.listIngredients);
    String textMissed = '';
    if (missedIngredientsQuant == 1) {
      textMissed = "Falta 1 ingrediente";
    } else if (missedIngredientsQuant > 1) {
      textMissed = "Faltam $missedIngredientsQuant ingredientes";
    }
    return GestureDetector(
      child: Card(
        child: Column(
          children: [
            ImageCached(
              recipe.picture,
              width: context.width / 2.1,
            ),
            // Image.network(
            //   recipe.picture,
            //   width: context.width / 2.1,
            //   height: 120,
            //   fit: BoxFit.cover,
            //   errorBuilder: (context, url, error) => const Icon(Icons.error),
            // ),
            Container(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  recipe.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 18),
                ),
                missedIngredientsQuant != 0
                    ? Text(
                        textMissed,
                        style: const TextStyle(
                            fontSize: 15, color: AppColor.dark5),
                      )
                    : Container(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: Stars.avaliation(
                      rating: recipe.avaliation.ratingAverage,
                    ))
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

  Widget cardFilter({required Widget child, required void Function()? action}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
              onPressed: action,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColor.dark1)),
              child: child),
        ));
  }

  Widget listFilters() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...controller.listFilters.map((e) {
              return cardFilter(
                  child: e.widget(color: AppColor.light, home: true),
                  action: () => controller.removeFilter(e.id));
            }).toList()
          ],
        ));
  }
}
