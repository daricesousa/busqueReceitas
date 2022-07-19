import 'package:busque_receitas/app/modules/pageView/despensa/despensa_controller.dart';
import 'package:get/get.dart';
import './layout_controller.dart';

class LayoutBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(LayoutController());
        Get.put(DespensaController());
    }
}