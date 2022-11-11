import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final storage = GetStorage();

  gotoNextScreen() {
    if (storage.read('token') == null || storage.read('token') == '') {
      Get.offAllNamed(Routes.login);
    } else {
      Get.offAllNamed(Routes.home);
    }
  }

  Timer? timer;

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 2), gotoNextScreen);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Center(
          child: Text('Chit App', style: Theme.of(context).textTheme.headline5),
        ),
      ),
    );
  }
}
