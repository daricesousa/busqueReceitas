import 'package:get/get.dart';
import './recipe_controller.dart';

class RecipeBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(RecipeController());
    }
}