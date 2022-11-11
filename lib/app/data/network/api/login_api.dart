import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../service/logging_interceptor.dart';

class LoginApi {
  final Dio dio = Dio()..interceptors.add(LoggingInterceptor());

  var options = Options(headers: {Headers.acceptHeader: 'application/json'});

  Future<Response> login(Map<String, String> data) async {
    try {
      final Response response = await dio.post(AppUrl.login, data: data, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
