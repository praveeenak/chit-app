import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';

import '../../../data/network/api/login_api.dart';
import '../../../data/network/service/api_exception.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';
import '../../chitty/index.dart';
import '../../coordinator/index.dart';

class LoginController extends GetxController {
  final LoginApi _loginApi = LoginApi();

  final _storage = GetStorage();

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> login(String email, String password) async {
    try {
      _isLoading.value = true;
      var body = {'email': email, 'password': password};
      final Response response = await _loginApi.login(body);
      if (response.statusCode == 200) {
        _storage.write('token', response.data['token']);
        _storage.write('email', response.data['email']);
        _storage.write('name', response.data['name']);
        await Future.delayed(1.seconds);

        await Get.put(CoordinatorController()).getCoordinator();
        final coordinator = Get.put(CoordinatorController()).coordinators;
        _isLoading.value = false;
        if (coordinator.isEmpty) {
         
          Get.offAll(() => const CreateCoordinator(isFirstTime: true));
        } else {
          await Get.offAllNamed(Routes.home);
        }
      } else {
        _isLoading.value = false;
      }
    } on DioError catch (e) {
      _isLoading.value = false;
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error, title: 'Login failed');
    }
  }
}
