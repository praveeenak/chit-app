import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';

import '../../../data/model/customer.dart';
import '../../../data/network/api/customer_api.dart';
import '../../../data/network/service/api_exception.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_success_dialog.dart';
import '../../home/controllers/home_controller.dart';

class CustomerController extends GetxController
    with StateMixin<List<Customer>> {
  final CustomerApi _customerApi = CustomerApi();

  final RxList<Customer> _customers = <Customer>[].obs;
  List<Customer> get customers => _customers;

  final RxList<Customer> _tempCustomer = <Customer>[].obs;

  final RxList<Customer> _dueCustomers = <Customer>[].obs;
  List<Customer> get dueCustomers => _customers;

  final RxList<Customer> _dueTempCustomer = <Customer>[].obs;

  final GetStorage _storage = GetStorage();

  String get chittyId => _storage.read('chitty-id').toString();

  Future<void> getCustomer() async {
    try {
      final response = await _customerApi.getCustomer();
      if (response.statusCode == 200) {
        final customersModel = customerModelFromJson(jsonEncode(response.data));
        final List<Customer> customers = customersModel.customers ?? [];
        if (customers.isNotEmpty) {
          _customers.assignAll(customers);
          _tempCustomer.assignAll(customers);
          change(customers, status: RxStatus.success());
          await Get.put(HomeController()).getHomeData();
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error('Error to get customers'));
      }
    } on DioError catch (e) {
      final error = ApiException.fromDioError(e).toString();
      change(null, status: RxStatus.error());
      Utils.showErrorSnackBar(message: error);
    }
  }

  Future<void> getDueCustomer() async {
    try {
      final response = await _customerApi.getDueCustomer();
      if (response.statusCode == 200) {
        final customersModel = customerModelFromJson(jsonEncode(response.data));
        final List<Customer> customers = customersModel.customers ?? [];
        if (customers.isNotEmpty) {
          _dueCustomers.assignAll(customers);
          _dueTempCustomer.assignAll(customers);
          change(customers, status: RxStatus.success());
          await Get.put(HomeController()).getHomeData();
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error('Error to get customers'));
      }
    } on DioError catch (e) {
      final error = ApiException.fromDioError(e).toString();
      change(null, status: RxStatus.error());
      Utils.showErrorSnackBar(message: error);
    }
  }

  //create customer
  Future<bool> createCustomer(Customer customer) async {
    try {
      Utils.showLoadingDialog();
      var data = customer.toJson();
      final response = await _customerApi.createCustomer(data);
      if (response.statusCode == 200) {
        Utils.hideLoadingDialog();
        await getCustomer();
        return true;
      } else {
        Utils.hideLoadingDialog();
      }
    } on DioError catch (e) {
      Utils.hideLoadingDialog();
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(
          message: error, title: 'Error to create customer');
    }
    return false;
  }

  //edit customer
  Future<void> editCustomer(Customer customer) async {
    try {
      Utils.showLoadingDialog();
      var data = customer.toJson();
      final response =
          await _customerApi.editCustomer(customer.id.toString(), data);
      if (response.statusCode == 200) {
        Utils.hideLoadingDialog();
        await getCustomer();
        Get.back();
        Get.dialog(const CustomSuccessDialog(), barrierDismissible: false);
      } else {
        Utils.hideLoadingDialog();
      }
    } on DioError catch (e) {
      Utils.hideLoadingDialog();
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error, title: 'Error to edit customer');
    }
  }

  //delete customer

  Future<void> deleteCustomer(String id) async {
    try {
      Utils.showLoadingDialog();
      final response = await _customerApi.deleteCustomer(id);
      if (response.statusCode == 200) {
        getCustomer();
        Utils.hideLoadingDialog();
      } else {
        Utils.hideLoadingDialog();
      }
    } on DioError catch (e) {
      Utils.hideLoadingDialog();
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(
          message: error, title: 'Error to delete customer');
    }
  }

  //search customer
  void searchCustomer(String value) {
    if (value.isEmpty) {
      _customers.assignAll(_tempCustomer);
      change(_customers, status: RxStatus.success());
    } else {
      _customers.assignAll(_tempCustomer.where((element) =>
          element.name!.toLowerCase().contains(value.toLowerCase()) ||
          element.phone!.contains(value)));
      change(_customers, status: RxStatus.success());
    }
  }

  //search due customer
  void searchDueCustomer(String value) {
    if (value.isEmpty) {
      _dueCustomers.assignAll(_dueTempCustomer);
      change(_dueCustomers, status: RxStatus.success());
    } else {
      _dueCustomers.assignAll(_dueTempCustomer.where((element) =>
          element.name!.toLowerCase().contains(value.toLowerCase()) ||
          element.phone!.contains(value)));
      change(_dueCustomers, status: RxStatus.success());
    }
  }

  //mark as winner
  Future<void> markAsWinner({required String customerId}) async {
    try {
      Utils.showLoadingDialog();
      var data = {'chitty_id': chittyId, 'customer_id': customerId};
      final response = await _customerApi.markWinner(data);
      if (response.statusCode == 200) {
        Utils.hideLoadingDialog();
        await getCustomer();
        Get.back();
        Get.dialog(const CustomSuccessDialog(), barrierDismissible: false);
        Get.snackbar(
          'Success',
          'Marked as winner',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(10),
        );
      } else {
        Utils.hideLoadingDialog();
      }
    } on DioError catch (e) {
      Utils.hideLoadingDialog();
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error, title: 'Error to mark as winner');
    }
  }

  @override
  void onInit() {
    getCustomer();

    super.onInit();
  }
}

class WinnerController extends GetxController with StateMixin<List<Customer>> {
  final RxList<Customer> _winners = <Customer>[].obs;
  List<Customer> get winners => _winners;

  final CustomerApi _customerApi = CustomerApi();

  getWinnedCustomer() async {
    try {
      final response = await _customerApi.getWinnerList();
      if (response.statusCode == 200) {
        Utils.hideLoadingDialog();
        final customersModel = customerModelFromJson(jsonEncode(response.data));
        final List<Customer> customers = customersModel.customers!;
        if (customers.isNotEmpty) {
          _winners.value = customers;
          change(customers, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error('Error to get customers'));
      }
    } on DioError catch (e) {
      final error = ApiException.fromDioError(e).toString();
      change(null, status: RxStatus.error());
      Utils.showErrorSnackBar(message: error);
    }
  }
}

class DuoCustomerController extends GetxController
    with StateMixin<List<Customer>> {
  final RxList<Customer> _dueCustomers = <Customer>[].obs;
  List<Customer> get dueCustomers => _dueCustomers;

  final RxList<Customer> _dueTempCustomer = <Customer>[].obs;

  final CustomerApi _customerApi = CustomerApi();

  getDueCustomer() async {
    try {
      final response = await _customerApi.getDueCustomer();
      if (response.statusCode == 200) {
        Utils.hideLoadingDialog();
        final customersModel = customerModelFromJson(jsonEncode(response.data));
        final List<Customer> customers = customersModel.customers!;
        if (customers.isNotEmpty) {
          _dueCustomers.value = customers;
          _dueTempCustomer.value = customers;
          change(customers, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error('Error to get customers'));
      }
    } on DioError catch (e) {
      final error = ApiException.fromDioError(e).toString();
      change(null, status: RxStatus.error());
      Utils.showErrorSnackBar(message: error);
    }
  }

  //search due customer
  void searchDueCustomer(String value) {
    if (value.isEmpty) {
      _dueCustomers.assignAll(_dueTempCustomer);
      change(_dueCustomers, status: RxStatus.success());
    } else {
      _dueCustomers.assignAll(_dueTempCustomer.where((element) =>
          element.name!.toLowerCase().contains(value.toLowerCase()) ||
          element.phone!.contains(value)));
      change(_dueCustomers, status: RxStatus.success());
    }
  }

  @override
  void onInit() {
    getDueCustomer();
    super.onInit();
  }
}
