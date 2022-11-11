import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class Utils {
  Utils._();
  static showErrorSnackBar({String title = 'Error !', required String message}) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(8),
      dismissDirection: DismissDirection.startToEnd,
      icon: const Icon(FeatherIcons.xCircle, color: Colors.white),
    );
  }

  static showLoadingDialog() {
    Get.dialog(
      name: 'Loading',
      WillPopScope(
        onWillPop: () async => false,
        child: const Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )),
      ),
      barrierDismissible: false,
    );
  }

  static hideLoadingDialog() {
    if (Get.isDialogOpen!) Get.back();
  }
}
