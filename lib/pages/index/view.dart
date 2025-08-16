import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/controller/auth_controller.dart';
import 'package:voidlord/pages/index/components/salomon_botton_bar.dart';
import 'package:voidlord/pages/index/controller.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    var indexController = Get.find<IndexController>();
    final auth = Get.find<AuthController>();
    return Obx(() {
      final isAdmin = auth.isAdmin.value;
      final items = <SalomonBottomBarItem>[];
      items.add(SalomonBottomBarItem(
          icon: const Icon(Icons.home_outlined), title: const Text("主页")));
      items.add(SalomonBottomBarItem(
          icon: const Icon(Icons.shelves), title: const Text("书架")));
      if (isAdmin) {
        items.add(SalomonBottomBarItem(
            icon: const Icon(Icons.admin_panel_settings_outlined),
            title: const Text("管理")));
      }
      items.add(SalomonBottomBarItem(
          icon: const Icon(Icons.account_circle_outlined),
          title: const Text("我的")));

      return Scaffold(
        body: indexController.pages[indexController.selectIndex.value],
        bottomNavigationBar: SalomonBottomBar(
          selectedItemColor: Get.theme.colorScheme.primary,
          currentIndex: indexController.selectIndex.value,
          onTap: (index) => indexController.selectIndex.value = index,
          items: items,
        ),
      );
    });
  }
}
