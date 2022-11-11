import 'package:get/get.dart';

import '../controller/coordinator_controller.dart';

class CoordinatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoordinatorController>(
      () => CoordinatorController(),
    );
  }
}
