import 'package:get/get.dart';

import '../modules/chitty/index.dart';
import '../modules/coordinator/index.dart';
import '../modules/customer/index.dart';
import '../modules/home/index.dart';
import '../modules/login/index.dart';
import '../modules/transaction/index.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.initial;

  static final routes = [
    GetPage(
      name: Routes.initial,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),

    //* Customer Routes
    GetPage(
      name: Routes.customer,
      page: () => const CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: Routes.addCustomer,
      page: () => const AddCustomer(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: Routes.editCustomer,
      page: () => const EditCustomer(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: Routes.customerDetails,
      page: () => CustomerDetailsView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: Routes.dueCustomer,
      page: () => const DueMembers(),
      binding: CustomerBinding(),
    ),

    //* Transaction Routes
    GetPage(
      name: Routes.transaction,
      page: () => const TransactionView(),
      binding: TransactionBindings(),
    ),
    GetPage(
      name: Routes.createTransaction,
      page: () => const CreateTransaction(),
      binding: TransactionBindings(),
    ),

    //* Coordinator Routes
    GetPage(
      name: Routes.coordinators,
      page: () => const CoordinatorView(),
      binding: CoordinatorBinding(),
    ),
    GetPage(
      name: Routes.createCoordinator,
      page: () => const CreateCoordinator(),
      binding: CoordinatorBinding(),
    ),

    //* Chitty Routes
    GetPage(
      name: Routes.createChitty,
      page: () => const CreateChitty(),
      binding: ChittyBindings(),
    ),
  ];
}
