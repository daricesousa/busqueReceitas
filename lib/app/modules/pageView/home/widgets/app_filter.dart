import 'package:busque_receitas/app/core/ui/app_theme.dart';
import 'package:busque_receitas/app/core/widgets/app_button.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFilter extends StatefulWidget {
  const AppFilter({Key? key}) : super(key: key);

  @override
  State<AppFilter> createState() => _AppFilterState();
}

class _AppFilterState extends State<AppFilter> {
  final listPantry = Get.find<HomeController>().listPantry;
  final nameIngredient = Get.find<SplashController>().nameIngredient;
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
          ListView(
            shrinkWrap: true,
            children: [
              ExpansionTile(
                title: const Text("Dificuldade"),
                children: [
                  wrap(
                    [
                      card(child: apptext("Fácil")),
                      card(child: apptext("Médio")),
                      card(child: apptext("Díficil")),
                    ],
                  )
                ],
              ),
              ExpansionTile(
                title: const Text("Avaliação"),
                children: [
                  wrap(
                    [
                      card(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                        ...star(1),
                        apptext(" e acima"),
                      ])),
                      card(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                        ...star(2),
                        apptext(" e acima"),
                      ])),
                      card(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                        ...star(3),
                        apptext(" e acima"),
                      ])),
                      card(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                        ...star(4),
                        apptext(" e acima"),
                      ])),
                      card(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                        ...star(5),
                        apptext(" e acima"),
                      ])),
                    ],
                  )
                ],
              ),
              ExpansionTile(
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
                            listPantry.map((e) {
                              return card(
                                child: apptext(
                                  nameIngredient(e),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ))
                ],
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppButton(
                onPressed: () {},
                label: "Limpar filtros",
              ),
              AppButton(
                onPressed: () {},
                label: "Filtrar",
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget card({required child, Color color = Colors.green}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: AppTheme.boxDecoration(color: color),
          child: child,
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
      list.add(Icon(Icons.star, color: Colors.white, size: 15));
    }
    return list;
  }
}
