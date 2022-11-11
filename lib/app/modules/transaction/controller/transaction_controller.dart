import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../../data/model/customer.dart';
import '../../../data/model/recent_model.dart';
import '../../../data/model/success_model.dart';
import '../../../data/model/transaction.dart';
import '../../../data/network/api/transaction_api.dart';
import '../../../data/network/service/api_exception.dart';
import '../../../utils/utils.dart';
import '../../home/index.dart';
import '../index.dart';

class TransactionController extends GetxController with StateMixin {
  final RxList<Transaction> _transactions = <Transaction>[].obs;
  List<Transaction> get transactions => _transactions;

  final TransactionApi _transactionApi = TransactionApi();

  final RxList<Transaction> _tempTransaction = <Transaction>[].obs;
  List<Transaction> get tempTransaction => _tempTransaction;

  Future<void> getTransactions({String month = 'all'}) async {
    try {
      final response = await _transactionApi.getTransactions(month: month);
      if (response.statusCode == 200) {
        final List<Transaction> data = transactionModelFromJson(jsonEncode(response.data)).transactions!;
        if (data.isNotEmpty) {
          _transactions.assignAll(data);
          change(data, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error('Error'));
      }
    } on DioError catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error);
    }
  }

  Future<void> createTransaction(Transaction transaction, Customer customer) async {
    try {
      Utils.showLoadingDialog();
      var data = transaction.toJson();
      Get.log(data.toString());

      final response = await _transactionApi.createTransaction(data);
      if (response.statusCode == 200) {
        final SuccessTransaction transactionsData = successTransactionFromJson(jsonEncode(response.data));
        Utils.hideLoadingDialog();
        Get.to(() => ReceiptView(), arguments: [customer, transactionsData.transactions]);
        await getTransactions();
        await Get.put(HomeController()).getHomeData();
      } else {
        Utils.hideLoadingDialog();
      }
    } on DioError catch (e) {
      Utils.hideLoadingDialog();
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error, title: 'Error');
    } catch (e) {
      Utils.hideLoadingDialog();
      Utils.showErrorSnackBar(message: e.toString(), title: 'Error');
      rethrow;
    }
  }

  //getCustomerTransactions
  Future<void> getCustomerTransactions(String customerId) async {
    try {
      final response = await _transactionApi.getCustomerTransactions(id: customerId);
      if (response.statusCode == 200) {
        final List<Transaction> data = transactionModelFromJson(jsonEncode(response.data)).transactions!;
        if (data.isNotEmpty) {
          _tempTransaction.assignAll(data);
          change(data, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error('Error'));
      }
    } on DioError catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error);
    }
  }

  showFilterOption() async {
    await showMonthYearPicker(
      context: Get.context!,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      initialDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        getTransactions(month: value.month.toString());
      }
    });
  }

  @override
  void onInit() {
    getTransactions();

    super.onInit();
  }
}

class RecentTransactionController extends GetxController with StateMixin {
  final RxList<Transactions> _transactions = <Transactions>[].obs;
  List<Transactions> get transactions => _transactions;

  final TransactionApi _transactionApi = TransactionApi();

  String get totalAmount {
    if (transactions.isNotEmpty) {
      return _transactions.map((e) => e.amount ?? 0).reduce((value, element) => value + element).toString();
    }
    return '0';
  }

  String get withDrawAmount {
    if (transactions.isNotEmpty) {
      return (_transactions.map((e) => e.amount ?? 0).reduce((value, element) => value + element) - 1000).toString();
    }
    return '0';
  }

  Future<void> getRecentTransactions({required String id}) async {
    try {
      final response = await _transactionApi.getCustomerTransactions(id: id);
      if (response.statusCode == 200) {
        final RecentTransaction data = recentTransactionFromJson(jsonEncode(response.data));
        if (data.transactions!.isNotEmpty) {
          _transactions.assignAll(data.transactions!);
          change(data, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error('Error'));
      }
    } on DioError catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error);
    }
  }
}
