import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../index.dart';

class CustomerTransactions extends GetView<RecentTransactionController> {
  CustomerTransactions(this.id, {super.key}) {
    controller.getRecentTransactions(id: id);
  }

  final String id;

  @override
  RecentTransactionController get controller => Get.put(RecentTransactionController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Transactions', style: TextStyle(fontSize: 17)),
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Amount (Rs)'), numeric: true),
            ],
            rows: controller.transactions
                .map(
                  (transaction) => DataRow(
                    cells: [
                      DataCell(Text(transaction.date.toString())),
                      DataCell(Text(transaction.amount.toString())),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        onEmpty: const Center(child: Text('No transactions')),
      ),
      bottomNavigationBar: Obx(() => Visibility(
            visible: controller.transactions.isNotEmpty,
            child: BottomAppBar(
              child: SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Amount', style: theme.textTheme.bodyMedium),
                          Text(
                            'Rs. ${controller.totalAmount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('With Draw Amount', style: theme.textTheme.bodyMedium),
                              const SizedBox(width: 4),
                              Text('(${controller.totalAmount} - 1000)', style: theme.textTheme.caption),
                            ],
                          ),
                          Text(
                            'Rs. ${controller.withDrawAmount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
