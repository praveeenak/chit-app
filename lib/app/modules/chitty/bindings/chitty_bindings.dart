

import 'package:get/get.dart';

import '../controller/chitty_controller.dart';

class ChittyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChittyController>(
      () => ChittyController(),
    );
  }

  
}