import 'package:get/get.dart';
import './recipe_validation_controller.dart';

class RecipeValidationBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(RecipeValidationController(recipe: Get.arguments));
    }
}