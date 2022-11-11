part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const initial = '/';
  static const home = '/home';
  static const login = '/login';

  static const customer = '/customer';
  static const addCustomer = '/add-customer';
  static const editCustomer = '/edit-customer';
  static const customerDetails = '/customer-details';
  static const dueCustomer = '/due-customer';

  static const transaction = '/transaction';
  static const createTransaction = '/create-transaction';


  static const coordinators = '/coordinators';
  static const createCoordinator = '/create-coordinator';

  static const createChitty = '/create-chitty';
}
