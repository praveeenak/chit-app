import 'package:get/get.dart';

import '../controller/transaction_controller.dart';

class TransactionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionController>(() => TransactionController());
  }
}
