import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_constants.dart';
import '../../../data/model/customer.dart';
import '../index.dart';

class WinnerList extends GetView<WinnerController> {
  WinnerList({super.key}) {
    controller.getWinnedCustomer();
  }

  @override
  WinnerController get controller => Get.put(WinnerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Winners',
          style: AppConstants.kAppBarTextStyle,
        ),
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: DataTable(
            columnSpacing: 30,
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Chitty Number'), numeric: true),
              DataColumn(label: Text('Month'), numeric: true),
            ],
            rows: controller.winners
                .map(
                  (customer) => DataRow(
                    onLongPress: () => showChangeWinnerDialog(customer),
                    cells: [
                      DataCell(Text(customer.name.toString())),
                      DataCell(Text(customer.chittyNumber!)),
                      DataCell(Text(DateFormat('MMMM').format(customer.createdAt!))),
                    ],
                  ),
                )
                .toList(),
            headingTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onEmpty: const Center(child: Text('No Winners')),
        onError: (error) => Center(child: Text(error.toString())),
      ),
    );
  }

  showChangeWinnerDialog(Customer customer) {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) => AlertDialog(
        title: const Text('Change Winner'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to change the winner?'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // controller.changeWinner();
                    Get.back();
                  },
                  child: const Text('Change'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
