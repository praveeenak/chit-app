import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../service/api_service.dart';

class CoordinatorApi {
  final ApiService _apiService = ApiService();

  Future<Response> getCoordinator() async {
    try {
      final Response response = await _apiService.get(AppUrl.coordinators);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getCoordinatorById(String id) async {
    try {
      final Response response = await _apiService.get('${AppUrl.coordinators}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createCoordinator(Map<String, dynamic> data) async {
    try {
      final Response response = await _apiService.post(AppUrl.coordinators, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateCoordinator(String id, Map<String, dynamic> data) async {
    try {
      final Response response = await _apiService.put('${AppUrl.coordinators}/$id', data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteCoordinator(String id) async {
    try {
      final Response response = await _apiService.delete('${AppUrl.coordinators}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
