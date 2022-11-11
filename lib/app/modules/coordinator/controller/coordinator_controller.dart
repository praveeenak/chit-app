import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/model/coordinator.dart';
import '../../../data/network/api/coordinator_api.dart';
import '../../../data/network/service/api_exception.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';

class CoordinatorController extends GetxController with StateMixin<List<Coordinator>> {
  final CoordinatorApi _coordinatorApi = CoordinatorApi();

  final RxList<Coordinator> _coordinators = <Coordinator>[].obs;
  List<Coordinator> get coordinators => _coordinators;
  final RxList<Coordinator> _tempCoordinator = <Coordinator>[].obs;

  Future<void> getCoordinator() async {
    try {
      final response = await _coordinatorApi.getCoordinator();
      if (response.statusCode == 200) {
        final coordinatorModel = coordinatorModelFromJson(jsonEncode(response.data));
        final List<Coordinator> coordinators = coordinatorModel.coordinators ?? [];
        if (coordinators.isNotEmpty) {
          _coordinators.assignAll(coordinators);
          _tempCoordinator.assignAll(coordinators);
          change(coordinators, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.empty());
        }
      } else {
        change(null, status: RxStatus.error('Error to get coordinators'));
      }
    } on DioError catch (e) {
      final error = ApiException.fromDioError(e).toString();
      change(null, status: RxStatus.error());
      Utils.showErrorSnackBar(message: error);
    }
  }

  //create coordinator
  Future<bool> createCoordinator(Coordinator coordinator, {bool isFirstTime = false}) async {
    try {
      Utils.showLoadingDialog();
      var data = coordinator.toJson();
      final response = await _coordinatorApi.createCoordinator(data);
      if (response.statusCode == 200) {
        Utils.hideLoadingDialog();
        await getCoordinator();
        if (isFirstTime) {
          Get.offAllNamed(Routes.home);
        } else {
          return true;
        }
      } else {
        Utils.hideLoadingDialog();
      }
    } on DioError catch (e) {
      Utils.hideLoadingDialog();
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error, title: 'Error to create coordinator');
    }
    return false;
  }

  //delete coordinator
  Future<void> deleteCoordinator(String id) async {
    try {
      Utils.showLoadingDialog();
      final response = await _coordinatorApi.deleteCoordinator(id);
      if (response.statusCode == 200) {
        getCoordinator();
      } else {
        Utils.hideLoadingDialog();
      }
    } on DioError catch (e) {
      Utils.hideLoadingDialog();
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error, title: 'Error to delete coordinator');
    }
  }

  //search coordinator
  void searchCoordinator(String query) {
    if (query.isEmpty) {
      _coordinators.assignAll(_tempCoordinator);
      change(_coordinators, status: RxStatus.success());
    } else {
      final List<Coordinator> coordinators = _tempCoordinator
          .where((coordinator) => coordinator.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      if (coordinators.isNotEmpty) {
        _coordinators.assignAll(coordinators);
        change(_coordinators, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    }
  }

  @override
  void onInit() {
    getCoordinator();
    super.onInit();
  }
}
