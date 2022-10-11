import 'package:busque_receitas/app/core/ui/app_color.dart';
import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/ui/app_view.dart';
import 'package:busque_receitas/app/core/utils/enumDifficulty.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:busque_receitas/app/models/recipe/filter_recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/filter_recipe/filter_recipe_controller.dart';
import 'package:flutter/material.dart';

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
                label: "Limpar filtros",
                color: AppColor.light,
                textColor: AppColor.dark2,
                borderColor: AppColor.dark2,
              ),
              AppButton(
                onPressed: controller.filter,
                label: "Filtrar",
                color: AppColor.dark1,
                textColor: AppColor.light5,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget card(
      {required child, required dynamic value, required type, Color? color}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              controller.changeCard(type: type, title: child, value: value);
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

  Widget apptext({required String title, Color? color}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15, color: color),
    );
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

  List<Widget> star({required int quantity, required Color color}) {
    return List.generate(
        quantity,
        (index) => Icon(
              Icons.star,
              color: color,
              size: 15,
            ));
  }

  Widget filterDifficulty() {
    return ExpansionTile(
      title: const Text("Dificuldade"),
      children: [
        wrap(Difficulty.values.map((e) {
          final isSelected = controller.searchFilter(value: e);
          final textColor = isSelected ? AppColor.light : Colors.grey;
          final cardColor = isSelected ? AppColor.dark1 : AppColor.light5;
          return card(
              child: apptext(title: e.name, color: textColor),
              type: TypeFilters.difficulty,
              value: e,
              color: cardColor);
        }).toList())
      ],
    );
  }

  Widget filterAvaliation() {
    const type = TypeFilters.avaliation;
    return ExpansionTile(
      title: const Text("Avaliação"),
      children: [
        wrap(List.generate(5, (index) {
          final isSelected = controller.searchFilter(value: index);
          final textColor = isSelected ? AppColor.light : Colors.grey;
          final cardColor = isSelected ? AppColor.dark1 : AppColor.light5;
          return card(
            color: cardColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...star(quantity: index + 1, color: textColor),
                if (index <= 3)
                  apptext(
                    color: textColor,
                    title: " e acima",
                  )
              ],
            ),
            type: type,
            value: index,
          );
        }))
      ],
    );
  }

  Widget filterIngredient() {
    const type = TypeFilters.ingredient;
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

                    return card(
                      color: cardColor,
                      child: apptext(title: ingredient.name, color: textColor),
                      type: type,
                      value: ingredient,
                    );
                  }).toList(),
                ),
              ),
            ))
      ],
    );
  }
}
