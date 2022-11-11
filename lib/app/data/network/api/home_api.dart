import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../service/api_service.dart';

class HomeApi {
  final ApiService _apiService = ApiService();

  Future<Response> getHome() async {
    try {
      final Response response = await _apiService.get(AppUrl.home);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
