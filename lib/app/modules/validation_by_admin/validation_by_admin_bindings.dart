import 'package:get/get.dart';
import './validation_by_admin_controller.dart';

class ValidationByAdminBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ValidationByAdminController());
    }
}