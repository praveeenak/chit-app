import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_constants.dart';
import '../../../data/helper/pdf_helper.dart';
import '../../../data/model/customer.dart';
import '../../../data/model/success_model.dart';
import '../../../data/model/transaction.dart';
import '../../../routes/app_pages.dart';
import '../../chitty/controller/chitty_controller.dart';
import '../../customer/index.dart';
import '../controller/transaction_controller.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({super.key});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  Customer? selectedCustomer;

  @override
  Widget build(BuildContext context) {
    final customerController = Get.put(DuoCustomerController());
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Select a member', style: AppConstants.kAppBarTextStyle),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: TextField(
                onChanged: customerController.searchDueCustomer,
                decoration: const InputDecoration(
                  hintText: 'Search by name or phone',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Icon(FeatherIcons.search),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ),
          Expanded(
            child: customerController.obx(
              (state) => Scrollbar(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final customer = customerController.dueCustomers[index];
                    Color randomColor = Colors.primaries[index];
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      leading: CircleAvatar(
                        backgroundColor: randomColor,
                        foregroundColor: randomColor.computeLuminance() > 0.5
                            ? Colors.black
                            : Colors.white,
                        child: Text(customer.name![0].toUpperCase()),
                      ),
                      title: Text(customer.name!),
                      subtitle: Text(customer.phone!),
                      selected: selectedCustomer == customer,
                      selectedColor: Colors.green,
                      trailing: selectedCustomer == customer
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        setState(() => selectedCustomer = customer);
                      },
                    );
                  },
                  itemCount: customerController.dueCustomers.length,
                ),
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (error) => Center(child: Text(error.toString())),
              onEmpty: const Center(
                child: Text(
                  'No pending members',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: selectedCustomer != null ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton.extended(
          onPressed: () =>
              Get.to(() => const AddAmount(), arguments: selectedCustomer),
          label: const Text('Continue'),
          icon: const Icon(FeatherIcons.check),
        ),
      ),
    );
  }
}

class AddAmount extends StatefulWidget {
  const AddAmount({super.key});

  @override
  State<AddAmount> createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {
  final Customer customer = Get.arguments as Customer;
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  bool isFormValid = false;

  @override
  void initState() {
    _amountController.text = '1000';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    final chittyController = Get.put(ChittyController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Amount', style: AppConstants.kAppBarTextStyle),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ListTile(
          //   title: Text(chittyController.chittyId),
          //   subtitle: const Text('Chitty ID'),
          // ),
          // ListTile(
          //   title: Text(chittyController.chittyName),
          //   subtitle: const Text('Chitty Name'),
          // ),
          Center(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.primaries[10 % Colors.primaries.length],
              foregroundColor: Colors.primaries[10 % Colors.primaries.length]
                          .computeLuminance() >
                      0.5
                  ? Colors.black
                  : Colors.white,
              child: Text(customer.name![0].toUpperCase()),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            customer.name!,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 4),
          Text(
            customer.phone!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          Text('Chitty Number  #${customer.chittyNumber}'),

          Form(
            key: _formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _amountController,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Amount',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 20),
                alignLabelWithHint: true,
                constraints: BoxConstraints(minWidth: 50),

                // prefixText: 'Rs',
              ),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              showCursor: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }
                return null;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            try {
              final Transaction transaction = Transaction(
                customerId: customer.id,
                amount: int.parse(_amountController.text),
                chittyId: int.parse(chittyController.chittyId.toString()),
              );
              controller.createTransaction(transaction, customer);
            } on Exception {
              rethrow;
            }
          }
        },
        child: const Icon(FeatherIcons.check),
      ),
    );
  }
}

class ReceiptView extends StatelessWidget {
  ReceiptView({super.key});
  final RTransactions transaction = Get.arguments[1] as RTransactions;
  final Customer customer = Get.arguments[0] as Customer;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppConstants.kDefaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Transaction Added Successfully',
                style: theme.textTheme.headline5?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                DateFormat('dd-MMMM-yyyy').format(now),
                style: theme.textTheme.subtitle1,
              ),
              const SizedBox(height: 2),
              Text(
                DateFormat('EEEE').format(now),
                style: theme.textTheme.subtitle1,
              ),
              const SizedBox(height: 40),
              Text(transaction.transactionNo ?? '',
                  style:
                      theme.textTheme.headline4?.copyWith(color: Colors.black)),
              Text(transaction.customer!.chittyNumber ?? '',
                  style: theme.textTheme.subtitle2),
              const SizedBox(height: 40),
              Text(transaction.customer!.name ?? '',
                  style: theme.textTheme.titleLarge),
              Text(transaction.customer!.phone ?? '',
                  style: theme.textTheme.subtitle1),
              SizedBox(height: size.height * 0.02),
              const Divider(),
              ListTile(
                title: Text('Amount', style: theme.textTheme.subtitle1),
                subtitle: Text('₹ ${transaction.amount}',
                    style: theme.textTheme.headline5
                        ?.copyWith(color: Colors.black)),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: AppConstants.kDefaultPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade500),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () => Get.offAllNamed(Routes.home),
                  child: const Text('Go Back'),
                ),
              ),
              SizedBox(width: size.width * 0.02),
              Expanded(
                child: ElevatedButton(
                  child: const Text('Generate PDF'),
                  onPressed: () async {
                    final pdfData = PdfData(
                      tId: transaction.transactionNo ?? '',
                      amount: transaction.amount.toString(),
                      cId: transaction.customer!.chittyNumber ?? '',
                      cName: transaction.customer!.name ?? '',
                      cPhone: transaction.customer!.phone ?? '',
                    );
                    final File pdf =
                        await PdfHelper.generateTransactionPdf(data: pdfData);
                    await PdfHelper.openFile(pdf);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
