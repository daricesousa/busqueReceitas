import 'package:busque_receitas/app/modules/validation_page_view/validation_ingredients/validation_ingredients_controller.dart';
import 'package:busque_receitas/app/modules/validation_page_view/validation_recipes/validation_recipes_controller.dart';
import 'package:get/get.dart';
import './validation_layout_controller.dart';

class ValidationLayoutBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ValidationLayoutController());
        Get.put(ValidationIngredientsController());
    }
}