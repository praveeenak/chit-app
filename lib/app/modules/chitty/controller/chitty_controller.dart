import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/model/chitty_model.dart';
import '../../../data/network/api/chitty_api.dart';
import '../../../data/network/service/api_exception.dart';
import '../../../utils/utils.dart';

class ChittyController extends GetxController {
  RxInt count = 0.obs;

  final GetStorage _storage = GetStorage();

  String get chittyId => _storage.read('chitty-id').toString();
  String get chittyName => _storage.read('chitty-name');

  final ChittyApi _chittyApi = ChittyApi();

  Future<int?> getChittyCount() async {
    try {
      final response = await _chittyApi.getChittyCount();
      if (response.statusCode == 200) {
        return count.value = response.data['chittyCount'];
      }
    } on DioError catch (e) {
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error);
    }
    return null;
  }

  Future getChitty() async {
    try {
      final response = await _chittyApi.getChitty();
      if (response.statusCode == 200) {
        final ChittyModel chitty = chittyModelFromJson(jsonEncode(response.data));
        if (chitty.chitties!.isNotEmpty) {
          _storage.write('chitty-id', chitty.chitties![0].id);
          _storage.write('chitty-name', chitty.chitties![0].chittyName);
        }
      }
    } on DioError catch (e) {
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error);
    }
  }

  // Future createChistty({required String id, required String name}) async {
  //   try {
  //     Utils.showLoadingDialog();
  //     final data = {
  //       'id': id,
  //       'chitty_name': name,
  //     };
  //     final response = await _chittyApi.createChitty(data);
  //     if (response.statusCode == 200) {
  //       await getChittyCount();
  //       getChitty();
  //     } else {
  //       Utils.hideLoadingDialog();
  //     }
  //   } on DioError catch (e) {
  //     Utils.hideLoadingDialog();
  //     final error = ApiException.fromDioError(e).toString();
  //     Utils.showErrorSnackBar(message: error, title: 'Error');
  //   }
  // }
  @override
  void onInit() {
    getChitty();
    super.onInit();
  }
}
