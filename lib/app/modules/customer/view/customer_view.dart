import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../controller/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getCustomer();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members', style: AppConstants.kAppBarTextStyle),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Obx(
            () => Visibility(
              visible: controller.customers.isNotEmpty,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: TextField(
                    onChanged: controller.searchCustomer,
                    decoration: const InputDecoration(
                      hintText: 'Search by name',
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
            ),
          ),
          Expanded(
            child: controller.obx(
              (state) => Scrollbar(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final customer = controller.customers[index];
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
                      trailing: const Icon(FeatherIcons.chevronRight, size: 18),
                      onTap: () => Get.toNamed(Routes.customerDetails,
                          arguments: customer),
                    );
                  },
                  itemCount: controller.customers.length,
                ),
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (error) => Center(child: Text(error.toString())),
              onEmpty: const Center(
                child: Text(
                  'No Member Found !\n Click on + to add new member',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.addCustomer),
        icon: const Icon(FeatherIcons.userPlus),
        label: const Text('Add new Member'),
      ),
    );
  }
}
