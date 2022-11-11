import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../data/model/customer.dart';
import '../../../routes/app_pages.dart';
import '../../transaction/view/customer_transaction.dart';
import '../controller/customer_controller.dart';

class CustomerDetailsView extends GetView<CustomerController> {
  CustomerDetailsView({super.key});
  final Customer customer = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          customer.name ?? "",
          style: AppConstants.kAppBarTextStyle,
        ),
      ),
      body: Padding(
        padding: AppConstants.kDefaultPadding,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.primaryColor.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    leading: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.orange,
                      child: Icon(FeatherIcons.user, size: 17),
                    ),
                    title: Text('Name', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    subtitle: Text(customer.name!, style: theme.textTheme.bodyText1),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    leading: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.purple,
                      child: Icon(FeatherIcons.phone, size: 17),
                    ),
                    title: Text('Phone', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    subtitle: Text(customer.phone!, style: theme.textTheme.bodyText1),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    leading: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.pink,
                      child: Icon(FeatherIcons.hash, size: 17),
                    ),
                    title: Text('Chitty Number', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    subtitle: Text(customer.chittyNumber!, style: theme.textTheme.bodyText1),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    leading: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.green,
                      child: Icon(FeatherIcons.mail, size: 17),
                    ),
                    title: Text('Address', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    subtitle: Text(customer.address!, style: theme.textTheme.bodyText1),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      padding: AppConstants.kDefaultPadding,
                      minimumSize: const Size.fromHeight(40),
                      visualDensity: VisualDensity.compact,
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: showDeleteDialog,
                    label: const Text('Delete'),
                    icon: const Icon(FeatherIcons.trash, size: 18),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      padding: AppConstants.kDefaultPadding,
                      minimumSize: const Size.fromHeight(40),
                      visualDensity: VisualDensity.compact,
                      side: const BorderSide(color: Colors.blue),
                    ),
                    onPressed: () => Get.offNamed(Routes.editCustomer, arguments: customer),
                    label: const Text('Edit'),
                    icon: const Icon(FeatherIcons.edit, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                // foregroundColor: Colors.green,
                padding: AppConstants.kDefaultPadding,
                minimumSize: const Size.fromHeight(40),
                visualDensity: VisualDensity.compact,
                side: const BorderSide(color: Colors.black54),
              ),
              onPressed: () => Get.to(() => CustomerTransactions(customer.id.toString())),
              child: const Text('See All Transactions'),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                padding: AppConstants.kDefaultPadding,
                minimumSize: const Size.fromHeight(40),
                visualDensity: VisualDensity.compact,
                side: const BorderSide(color: Colors.green),
              ),
              label: const Text('Mark As Winner'),
              icon: const Icon(FeatherIcons.award, size: 15),
              onPressed: () {
                controller.markAsWinner(customerId: customer.id.toString());
              },
            ),
          ],
        ),
      ),
    );
  }

  showDeleteDialog() {
    Get.dialog(
      CupertinoAlertDialog(
        title: const Text('Delete Customer'),
        content: const Text('Are you sure you want to delete this customer?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () {
              if (Get.isDialogOpen!) Get.back();
              Get.back(result: true);
              controller.deleteCustomer(customer.id.toString());
            },
          ),
        ],
      ),
      name: 'deleteDialog',
    );
  }
}
