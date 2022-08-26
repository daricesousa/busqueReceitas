import 'package:busque_receitas/app/core/utils/image_convert.dart';
import 'package:busque_receitas/app/core/widgets/erro_page.dart';
import 'package:busque_receitas/app/core/widgets/stars.dart';
import 'package:busque_receitas/app/models/recipe/recipe_model.dart';
import 'package:busque_receitas/app/modules/pageView/home/home_controller.dart';
import 'package:busque_receitas/app/modules/pageView/home/widgets/app_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final controller = Get.find<HomeController>();

  @override
  void didChangeMetrics() {
    setState(() {});
    super.didChangeMetrics();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas'),
      ),
      body: Obx(() => body()),
      drawer: AppDrawer(onTap: () {}),
    );
  }

  Widget body() {
    if (!controller.visibleRefrash.value && controller.listRecipes.isEmpty) {
      return ErroPage(
          visible: controller.visibleRefrash.value,
          onPressed: () async{
            await controller.getRecipes();
    });
    }
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent: 200),
        itemCount: controller.listRecipes.length,
        itemBuilder: ((context, index) {
          final recipe = controller.listRecipes[index];
          return widgetRecipe(recipe);
        }));
  }

  Widget widgetRecipe(RecipeModel recipe) {
    return GestureDetector(
      child: Card(
        color: Colors.amber,
        child: Column(
          children: [
            ImageConvert.base64fromImage(
                base64String: recipe.picture, width: Get.width / 2.1),
            Container(height: 8),
            Text(
              recipe.title,
              style: const TextStyle(fontSize: 20),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: Stars.stars(rating: recipe.rating))
          ],
        ),
      ),
      onTap: () {
        controller.goPageRecipe(recipe);
      },
    );
  }
}
