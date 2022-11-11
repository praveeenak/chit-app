import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_pages.dart';
import '../../customer/view/winners_list.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({super.key});

  final storage = GetStorage();
  final String name = GetStorage().read('name');
  final String email = GetStorage().read('email');

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Text(name[0]),
              ),
              title: Text(name),
              subtitle: Text(email),
            ),
          ),
          const SizedBox(height: 30),
          buildTile(
            title: 'Home',
            icon: FeatherIcons.home,
          ),
          buildTile(
            title: 'Members',
            icon: FeatherIcons.users,
            onTap: () => Get.toNamed(Routes.customer),
          ),
          buildTile(
            title: 'Chitty Winners',
            icon: FeatherIcons.award,
            onTap: ()=>Get.to(()=>WinnerList()),
          ),
          buildTile(
            title: 'Recent Transactions',
            icon: FeatherIcons.list,
            onTap: () => Get.toNamed(Routes.transaction),
          ),
          // buildTile(
          //   title: 'Reports',
          //   icon: FeatherIcons.fileText,
          // ),
          buildTile(
            title: 'Logout',
            icon: FeatherIcons.logOut,
            onTap: () {
              storage.erase();
              Get.offAllNamed(Routes.login);
            },
          ),
        ],
      ),
    );
  }

  buildTile({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 6),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(FeatherIcons.chevronRight),
        visualDensity: VisualDensity.compact,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        onTap: () {
          Get.back();
          onTap?.call();
        },
      ),
    );
  }
}
