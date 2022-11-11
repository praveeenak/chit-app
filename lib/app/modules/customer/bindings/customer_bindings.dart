import 'package:get/get.dart';

import '../controller/customer_controller.dart';

class CustomerBinding with Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerController());
  }
}
