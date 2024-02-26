import 'package:get/get.dart';
import 'homepage_controller.dart';

class HomePageBindings extends Bindings {
    @override
    void dependencies() {
        Get.lazyPut<HomePageController>(() => HomePageController());
    }
}

