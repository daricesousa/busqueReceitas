import 'package:busque_receitas/app/modules/pageView/pantry/pantry_controller.dart';
import 'package:get/get.dart';
import './layout_controller.dart';

class LayoutBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(LayoutController());
        Get.put(PantryController());
    }
}