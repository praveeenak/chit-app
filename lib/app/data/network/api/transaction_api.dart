import 'package:dio/dio.dart';

import '../../../constants/app_url.dart';
import '../service/api_service.dart';

class TransactionApi {
  final ApiService _apiService = ApiService();

  Future<Response> getTransactions({required String month}) async {
    try {
      final Response response = await _apiService.get('${AppUrl.transactions}/$month');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createTransaction(Map<String, dynamic> data) async {
    try {
      final Response response = await _apiService.post(AppUrl.transactions, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getCustomerTransactions({required String id}) async {
    try {
      final Response response = await _apiService.get('${AppUrl.getTransactionCustomer}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getRecentTransactions({required String id}) async {
    try {
      final Response response = await _apiService.get('${AppUrl.getTransactionCustomer}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<Response> getDuoTransactions() async {
  //   try {
  //     final Response response = await _apiService.get(AppUrl.dueTransactions);
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
