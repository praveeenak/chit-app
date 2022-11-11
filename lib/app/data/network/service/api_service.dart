import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/app_url.dart';
import 'logging_interceptor.dart';

class ApiService {
  static String token = '';

  static getToken() async {
    final storage = GetStorage();
    token = storage.read('token') ?? '';
  }

  static final _options = BaseOptions(
    baseUrl: AppUrl.baseUrl,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    headers: {Headers.acceptHeader: 'application/json'},
  );

  final Dio _dio = Dio(_options)..interceptors.add(LoggingInterceptor());

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      await getToken();
      if (token != '') _dio.options.headers['Authorization'] = 'Bearer $token';
      final Response response = await _dio.get(url, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String url, {dynamic data}) async {
    try {
      await getToken();
      if (token != '') _dio.options.headers['Authorization'] = 'Bearer $token';
      final Response response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String url, {dynamic data}) async {
    try {
      await getToken();
      if (token != '') _dio.options.headers['Authorization'] = 'Bearer $token';

      final Response response = await _dio.put(url, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String url) async {
    try {
      await getToken();
      if (token != '') _dio.options.headers['Authorization'] = 'Bearer $token';
      final Response response = await _dio.delete(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
