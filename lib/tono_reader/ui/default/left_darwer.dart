import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/state/tono_left_drawer_controller.dart';

class LeftDarwer extends GetView<TonoLeftDrawerController> {
  const LeftDarwer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        TabBar(controller: controller.tabController, tabs: [
          Text("目录"),
          Text("书签"),
          Text("笔记"),
        ]),
        Expanded(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) => controller.tabController.animateTo(index),
            children: [
              Text("12"),
              Text("34"),
              Text("56"),
            ],
          ),
        )
      ],
    );
  }
}
