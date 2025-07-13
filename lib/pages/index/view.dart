import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/pages/index/components/salomon_botton_bar.dart';
import 'package:voidlord/pages/index/controller.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    var indexController = Get.find<IndexController>();
    return Obx(() => Scaffold(
          body: indexController.pages[indexController.selectIndex.value],
          bottomNavigationBar: SalomonBottomBar(
              selectedItemColor: Get.theme.colorScheme.primary,
              currentIndex: indexController.selectIndex.value,
              onTap: (index) => indexController.selectIndex.value = index,
              items: [
                SalomonBottomBarItem(
                    icon: Icon(Icons.home_outlined), title: Text("主页")),
                SalomonBottomBarItem(
                    icon: Icon(Icons.shelves), title: Text("书架")),
                SalomonBottomBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    title: Text("我的")),
              ]),
        ));
  }
}
