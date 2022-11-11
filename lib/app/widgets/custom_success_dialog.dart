import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomSuccessDialog extends StatefulWidget {
  const CustomSuccessDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSuccessDialog> createState() => _CustomSuccessDialogState();
}

class _CustomSuccessDialogState extends State<CustomSuccessDialog> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pop(context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: LottieBuilder.asset(
          'assets/animation/successful.json',
          repeat: false,
        ),
      ),
    );
  }
}
