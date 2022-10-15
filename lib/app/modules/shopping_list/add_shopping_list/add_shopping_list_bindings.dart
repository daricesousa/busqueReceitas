import 'package:get/get.dart';
import './add_shopping_list_controller.dart';

class AddShoppingListBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(AddShoppingListController());
    }
}