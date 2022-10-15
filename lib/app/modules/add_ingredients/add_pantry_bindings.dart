import 'package:get/get.dart';
import 'add_pantry_controller.dart';

class AddPantryBindings implements Bindings {
    @override
    void dependencies() {
      Get.put(AddPantryController());
    }
}