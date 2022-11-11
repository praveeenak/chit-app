import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../controller/coordinator_controller.dart';

class CoordinatorView extends GetView<CoordinatorController> {
  const CoordinatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordinator', style: AppConstants.kAppBarTextStyle),
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
                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      leading: CircleAvatar(
                        backgroundColor: randomColor,
                        foregroundColor: randomColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                        child: Text(customer.name![0].toUpperCase()),
                      ),
                      title: Text(customer.name!),
                      subtitle: Text(customer.phone!),
                    );
                  },
                  itemCount: controller.coordinators.length,
                ),
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (error) => Center(child: Text(error.toString())),
              onEmpty: const Center(
                child: Text(
                  'No Coordinator Found !\n Click on + to add new coordinator',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.createCoordinator),
        icon: const Icon(FeatherIcons.userPlus),
        label: const Text('Add new coordinator'),
      ),
    );
  }
}
