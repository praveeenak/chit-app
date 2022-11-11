import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Get.log('');
    Get.log('\x1B[33m REQUEST[${options.method}] => PATH: ${options.path}');
    Get.log('\x1B[33m REQUEST[${options.method}] => BODY: ${options.data}');
    Get.log('\x1B[33m REQUEST[${options.method}] => QUERY: ${options.queryParameters}');
    // Get.log('\x1B[33m REQUEST[${options.method}] => HEADERS: ${options.headers}');
    Get.log(options.uri.toString());

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Get.log('');
    // Get.log('\x1B[32m RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    Get.log('\x1B[32m RESPONSE[${response.statusCode}] => DATA: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Get.log('\x1B[31m ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    Get.log('\x1B[31m ERROR[${err.response?.statusCode}] => DATA: ${err.response?.data}');
    return super.onError(err, handler);
  }
}
