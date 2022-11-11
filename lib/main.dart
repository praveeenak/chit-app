import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetMaterialApp(
        title: "Chit Book",
        theme: AppTheme.lightTheme,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        localizationsDelegates: const [
          MonthYearPickerLocalizations.delegate,
        ],
        defaultTransition: Transition.rightToLeftWithFade,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
