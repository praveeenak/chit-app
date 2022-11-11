import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../constants/app_constants.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            if (sizingInformation.deviceScreenType ==
                DeviceScreenType.desktop) {
              return const LoginDesktop();
            }

            return const LoginPage();
          },
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(LoginController());
    return LayoutBuilder(builder: (context, constrains) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constrains.maxHeight,
          ),
          child: IntrinsicHeight(
            child: SafeArea(
              child: Padding(
                padding: AppConstants.kDefaultPadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Let sign you in',
                        style: theme.textTheme.headline4?.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Please enter your email and password to continue',
                        style: theme.textTheme.bodyText1?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 60),
                      LoginField(
                        controller: emailController,
                        hintText: 'Email',
                        iconData: FeatherIcons.mail,
                      ),
                      const SizedBox(height: 20),
                      LoginField(
                        controller: passwordController,
                        hintText: 'Password',
                        isObscure: true,
                      ),
                      const SizedBox(height: 70),
                      Obx(() => ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                if (controller.isLoading) return;
                                controller.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            child: controller.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Login'),
                          )),
                      // const Spacer(),
                      // Center(
                      //     child: Text(
                      //   '2022 © Chit App',
                      //   style: theme.textTheme.caption,
                      // )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final IconData? iconData;
  const LoginField({
    super.key,
    required this.hintText,
    this.controller,
    this.isObscure = false,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final RxBool obscureText = isObscure.obs;
    return Obx(
      () => TextFormField(
        controller: controller,
        obscureText: obscureText.value,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.bodyMedium
              ?.copyWith(color: Color.fromARGB(255, 63, 73, 206)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey, width: 0.6),
          ),
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: const BorderSide(color: Colors.red, width: 0.5),
          // ),
          // filled: true,
          // fillColor: theme.primaryColor.withOpacity(0.5),
          isDense: true,
          suffixIcon: isObscure
              ? IconButton(
                  onPressed: () => obscureText.value = !obscureText.value,
                  icon: Icon(
                    obscureText.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : Icon(iconData, color: Colors.grey),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}

class LoginDesktop extends StatelessWidget {
  const LoginDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.37,
        height: size.height * 0.6,
        padding: AppConstants.kDefaultPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 20,
            ),
          ],
        ),
        child: LoginPage(),
      ),
    );
  }
}
