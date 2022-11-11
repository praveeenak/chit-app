import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../data/model/coordinator.dart';
import '../controller/coordinator_controller.dart';

class SelectCoordinator extends GetView<CoordinatorController> {
  SelectCoordinator({super.key});

  final Rx<Coordinator> selectedCoordinator = Coordinator().obs;

  @override
  CoordinatorController get controller => Get.put(CoordinatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Coordinator',
          style: AppConstants.kAppBarTextStyle,
        ),
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
                onChanged: controller.searchCoordinator,
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
          Expanded(
            child: controller.obx(
              (state) => Scrollbar(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final customer = controller.coordinators[index];
                    Color randomColor = Colors.primaries[index];
                    return Obx(() => ListTile(
                          selected: selectedCoordinator.value.id == customer.id,
                          visualDensity: VisualDensity.compact,
                          leading: CircleAvatar(
                            backgroundColor: randomColor,
                            foregroundColor: randomColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                            child: Text(customer.name![0].toUpperCase()),
                          ),
                          title: Text(customer.name!),
                          subtitle: Text(customer.phone!),
                          onTap: () {
                            selectedCoordinator.value = customer;
                            Get.back(result: selectedCoordinator.value);
                          },
                          trailing: selectedCoordinator.value.id == customer.id
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : null,
                        ));
                  },
                  itemCount: controller.coordinators.length,
                ),
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (error) => Center(child: Text(error.toString())),
              onEmpty: const Center(
                child: Text(
                  'No Coordinator Found !',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
