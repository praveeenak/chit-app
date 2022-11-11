import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Transactions', style: TextStyle(fontSize: 17)),
        centerTitle: false,
        actions: [
          //filter
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              controller.showFilterOption();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.obx(
          (state) => ListView.separated(
            itemBuilder: (context, index) {
              final transaction = controller.transactions[index];
              return ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                leading: const CircleAvatar(child: Text('₹')),
                title: Text(transaction.customer?.name ?? ""),
                trailing: Text(
                  '₹ ${transaction.amountString}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                    "${DateFormat.yMMMd().format(transaction.createdAt!)} - ${DateFormat.jm().format(transaction.createdAt!)}"),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: controller.transactions.length,
          ),
          onEmpty: const Center(child: Text('No transactions')),
        ),
      ),
    );
  }
}
