import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_refresh_indicator.dart';
import '../controllers/home_controller.dart';
import '../widget/drawer_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chit App', style: TextStyle(fontSize: 17)),
      ),
      drawer: DrawerWidget(),
      body: CustomRefreshIndicator(
        onRefresh: controller.getHomeData,
        child: SingleChildScrollView(
          child: Padding(
            padding: AppConstants.kDefaultPadding,
            child: Column(
              children: [
                const SizedBox(height: 57),
                Text(
                  'Total Chit Amount (₹)',
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Obx(() => Text(
                      '₹${controller.totalAmountString}',
                      style: theme.textTheme.headline4?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(height: 40),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  children: [
                    HomeMenu(
                      icon: FeatherIcons.users,
                      title: 'Total Members',
                      count: controller.totalCustomer,
                      route: Routes.customer,
                      color: Colors.blue,
                    ),
                    HomeMenu(
                      icon: FeatherIcons.userCheck,
                      title: 'Total Coordinators',
                      count: controller.totalCoordinator,
                      route: Routes.coordinators,
                      color: Colors.green,
                    ),
                    HomeMenu(
                      icon: FeatherIcons.userX,
                      title: 'Due Members',
                      count: controller.dueCustomer,
                      route: Routes.dueCustomer,
                      color: Colors.red,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade500),
                      ),
                      //add new member
                      child: InkWell(
                        onTap: () => Get.toNamed(Routes.addCustomer),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: Icon(
                                  FeatherIcons.plus,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                            // const SizedBox(height: 18),
                            Text(
                              'Add New Member',
                              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(Routes.createTransaction),
        // onPressed: () => Get.to(() => const MyWidget()),
        icon: const Icon(Icons.add),
        label: const Text('Add Transaction'),
      ),
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({
    Key? key,
    required this.icon,
    required this.title,
    required this.count,
    required this.route,
    required this.color,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final RxInt count;
  final String route;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Icon(
                  FeatherIcons.users,
                  color: color,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            Obx(() => Text(
                  count.value.toString(),
                  style: theme.textTheme.headline5?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
