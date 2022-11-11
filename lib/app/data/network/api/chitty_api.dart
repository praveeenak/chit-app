import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../service/api_service.dart';

class ChittyApi {
  final ApiService _apiService = ApiService();

  Future<Response> getChittyCount() async {
    try {
      final Response response = await _apiService.get(AppUrl.chittyCount);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getChitty() async {
    try {
      final Response response = await _apiService.get(AppUrl.chitty);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createChitty(Map<String, dynamic> data) async {
    try {
      final Response response = await _apiService.post(AppUrl.chitty, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
