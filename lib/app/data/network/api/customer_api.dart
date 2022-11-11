import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../service/api_service.dart';

class CustomerApi {
  final ApiService _apiService = ApiService();

  Future<Response> getCustomer() async {
    try {
      final Response response = await _apiService.get(AppUrl.customers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getDueCustomer() async {
    try {
      final Response response = await _apiService.get(AppUrl.dueCustomers);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getCustomerById(String id) async {
    try {
      final Response response = await _apiService.get('${AppUrl.customers}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createCustomer(Map<String, dynamic> data) async {
    try {
      final Response response = await _apiService.post(AppUrl.customers, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> markWinner(Map<String, dynamic> data) async {
    try {
      final Response response = await _apiService.post(AppUrl.markWinner, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getWinnerList() async {
    try {
      final Response response = await _apiService.get(AppUrl.winners);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> editCustomer(String id, Map<String, dynamic> data) async {
    try {
      final Response response = await _apiService.put('${AppUrl.customers}/$id', data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteCustomer(String id) async {
    try {
      final Response response = await _apiService.delete('${AppUrl.customers}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
