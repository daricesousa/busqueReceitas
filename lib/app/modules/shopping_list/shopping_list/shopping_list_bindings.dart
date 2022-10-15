import 'package:get/get.dart';
import './shopping_list_controller.dart';

class ShoppingListBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ShoppingListController());
    }
}