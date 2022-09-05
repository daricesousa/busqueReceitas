import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/ui/app_view.dart';
import 'package:busque_receitas/app/core/utils/enumDifficulty.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:busque_receitas/app/models/recipe/filter_recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/filter_recipe/filter_recipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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
                onPressed: () {},
                label: "Limpar filtros",
              ),
              AppButton(
                onPressed: (){
                  Get.back();
                  controller.filter();

                },
                label: "Filtrar",
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget card({required child, required dynamic value, required type}) {
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
              color: controller.searchFilter(value: value)
                  ? Colors.green
                  : Colors.grey,
            ),
            child: child,
          ),
        ));
  }

  Widget apptext(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 15, color: Colors.white),
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

  List<Widget> star(int quantity) {
    List<Widget> list = [];
    for (int i = 0; i < quantity; i++) {
      list.add(const Icon(Icons.star, color: Colors.white, size: 15));
    }
    return list;
  }

  Widget filterDifficulty() {
    const type = TypeFilters.difficulty;
    return ExpansionTile(
      title: const Text("Dificuldade"),
      children: [
        wrap(
          [
            card(
              child: apptext("Fácil"),
              type: type,
              value: Difficulty.easy,
            ),
            card(
              child: apptext("Médio"),
              type: type,
              value: Difficulty.medium,
            ),
            card(
              child: apptext("Difícil"),
              type: type,
              value: Difficulty.hard,
            )
          ],
        )
      ],
    );
  }

  Widget filterAvaliation() {
    const type = TypeFilters.avaliation;
    return ExpansionTile(
      title: const Text("Avaliação"),
      children: [
        wrap([
          card(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [...star(1), apptext(" e acima")],
            ),
            type: type,
            value: 1,
          ),
          card(
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [...star(2), apptext(" e acima")]),
            type: type,
            value: 2,
          ),
          card(
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [...star(3), apptext(" e acima")]),
            type: type,
            value: 3,
          ),
          card(
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [...star(4), apptext(" e acima")]),
            type: type,
            value: 4,
          ),
        ])
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
                    return card(
                      child: apptext(ingredient.name),
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
