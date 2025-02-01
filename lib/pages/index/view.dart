import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/pages/index/componets/salomon_botton_bar.dart';
import 'package:voidlord/pages/index/controller.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    var indexController = Get.find<IndexController>();
    return Obx(() => Scaffold(
          appBar: AppBar(
            actions: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                      child: FractionallySizedBox(
                        heightFactor: 0.9,
                        child: SearchBar(
                          leading: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.search)),
                          hintText: "搜点什么",
                          elevation: WidgetStatePropertyAll(0),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.notifications_outlined),
                    SizedBox(width: 16),
                    Icon(Icons.person),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
          body: indexController.pages[indexController.selectIndex.value],
          bottomNavigationBar: SalomonBottomBar(
              selectedItemColor: Get.theme.colorScheme.primary,
              currentIndex: indexController.selectIndex.value,
              onTap: (index) => indexController.selectIndex.value = index,
              items: [
                SalomonBottomBarItem(
                    icon: Icon(Icons.home_outlined), title: Text("主页")),
                SalomonBottomBarItem(
                    icon: Icon(Icons.radio_button_on_outlined),
                    title: Text("动态")),
                SalomonBottomBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    title: Text("我的")),
              ]),
        ));
  }
}
