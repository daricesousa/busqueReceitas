import 'package:get/get.dart';
import './do_later_controller.dart';

class DoLaterBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(DoLaterController());
    }
}