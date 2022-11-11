import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/network/api/home_api.dart';
import '../../../data/network/service/api_exception.dart';
import '../../../utils/utils.dart';

class HomeController extends GetxController {
  final HomeApi _homeApi = HomeApi();

  final RxInt _totalAmount = 0.obs;
  final RxInt _totalCoordinator = 0.obs;
  final RxInt _totalCustomer = 0.obs;
  final RxInt _dueCustomer = 0.obs;

  RxInt get totalCoordinator => _totalCoordinator;
  RxInt get totalCustomer => _totalCustomer;
  RxInt get dueCustomer => _dueCustomer;

  String get totalAmountString =>
      _totalAmount.value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

  Future getHomeData() async {
    try {
      final response = await _homeApi.getHome();
      if (response.statusCode == 200) {
        _totalAmount.value = response.data['total_transactions_amount'];
        _totalCoordinator.value = response.data['total_coordinators'];
        _totalCustomer.value = response.data['total_customers'];
        _dueCustomer.value = response.data['due_customers'];
      }
    } on DioError catch (e) {
      final error = ApiException.fromDioError(e).toString();
      Utils.showErrorSnackBar(message: error);
    }
  }

  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }
}
