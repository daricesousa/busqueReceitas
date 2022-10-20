import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/ui/app_view.dart';
import 'package:busque_receitas/app/core/utils/enum_difficulty.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:busque_receitas/app/models/recipe/filter_recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/filter_recipe/filter_recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterRecipePage extends StatefulWidget {
  const FilterRecipePage({Key? key}) : super(key: key);

  @override
  State<FilterRecipePage> createState() => _FilterRecipePageState();
}

class _FilterRecipePageState
    extends AppView<FilterRecipePage, FilterRecipeController> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(shrinkWrap: true, children: [
            filterDifficulty(),
            filterAvaliation(),
            filterIngredient(),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppButton(
                onPressed: () => controller.clearFilters(context),
                color: AppColor.light,
                borderColor: AppColor.dark2,
                child: const Text("Limpar filtros", style: TextStyle(fontSize: 20, color: AppColor.dark2,)),
              ),
              Container(width: 10),
              AppButton(
                onPressed: controller.filter,
                color: AppColor.dark1,
                width: context.width / 5 * 1.5,
                child: const Text("Filtrar", style: TextStyle(fontSize: 20, color: AppColor.light1)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget filterDifficulty() {
    return ExpansionTile(
      title: const Text("Dificuldade"),
      children: [
        wrap(Difficulty.values.map((e) {
          final isSelected = controller.searchFilter(value: e);
          final textColor = isSelected ? AppColor.light : Colors.grey;
          final cardColor = isSelected ? AppColor.dark1 : AppColor.light5;
          final filter =
              FilterRecipeModel(type: TypeFilters.difficulty, value: e);
          return card(
              child: filter.widget(color: textColor),
              filter: filter,
              color: cardColor);
        }).toList())
      ],
    );
  }

  Widget filterAvaliation() {
    return ExpansionTile(
      title: const Text("Avaliação"),
      children: [
        wrap(List.generate(5, (index) {
          final isSelected = controller.searchFilter(value: index);
          final textColor = isSelected ? AppColor.light : Colors.grey;
          final cardColor = isSelected ? AppColor.dark1 : AppColor.light5;
          final filter =
              FilterRecipeModel(type: TypeFilters.avaliation, value: index);
          return card(
              color: cardColor,
              child: filter.widget(color: textColor),
              filter: filter);
        }))
      ],
    );
  }

  Widget filterIngredient() {
    return ExpansionTile(
      title: const Text("Ingrediente chave"),
      children: [
        Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: Scrollbar(
              thumbVisibility: true,
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: wrap(
                  controller.listIngredientsPantry.map((ingredient) {
                    final isSelected =
                        controller.searchFilter(value: ingredient);
                    final textColor = isSelected ? AppColor.light : Colors.grey;
                    final cardColor =
                        isSelected ? AppColor.dark1 : AppColor.light5;
                    final filter = FilterRecipeModel(
                        type: TypeFilters.ingredient, value: ingredient);
                    return card(
                      color: cardColor,
                      child: filter.widget(color: textColor),
                      filter: filter,
                    );
                  }).toList(),
                ),
              ),
            ))
      ],
    );
  }

//Widgets

  Widget card(
      {required child, required FilterRecipeModel filter, Color? color}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              controller.changeCard(filter: filter);
            });
          },
          child: Container(
              padding: const EdgeInsets.all(5),
              decoration: AppTheme.boxDecoration(
                color: color,
              ),
              child: child),
        ));
  }

  Widget wrap(List<Widget> list) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Wrap(
          spacing: 2,
          runSpacing: 2,
          alignment: WrapAlignment.spaceEvenly,
          children: list),
    );
  }
}
