import 'package:get/get.dart';
import './create_recipe_controller.dart';

class CreateRecipeBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(CreateRecipeController());
    }
}