import 'package:get/get.dart';
import 'add_ingredients_controller.dart';

class AddIngredientsBindings implements Bindings {
    @override
    void dependencies() {
      Get.put(AddIngredientsController(splashController: Get.find()));
    }
}