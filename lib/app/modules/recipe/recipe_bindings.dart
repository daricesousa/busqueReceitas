import 'package:busque_receitas/app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';
import './recipe_controller.dart';

class RecipeBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(RecipeController(recipe: Get.arguments, splashController: Get.find<SplashController>()));
    }
}