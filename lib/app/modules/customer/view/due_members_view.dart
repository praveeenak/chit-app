import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/app_constants.dart';
import '../index.dart';

class DueMembers extends GetView<DuoCustomerController> {
  const DueMembers({super.key});

  @override
  DuoCustomerController get controller => Get.put(DuoCustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Due Members',
          style: AppConstants.kAppBarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.obx(
          (state) => ListView.separated(
            itemCount: controller.dueCustomers.length,
            itemBuilder: (context, index) {
              final customer = controller.dueCustomers[index];
              Color randomColor = Colors.primaries[index];
              return ListTile(
                visualDensity: VisualDensity.compact,
                leading: CircleAvatar(
                  backgroundColor: randomColor,
                  foregroundColor: randomColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                  child: Text(customer.name![0].toUpperCase()),
                ),
                title: Text(customer.name!),
                subtitle: Text(customer.phone!),
                // trailing: const Icon(FeatherIcons.chevronRight, size: 18),
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) => const SizedBox(),
          ),
        ),
      ),
    );
  }
}
