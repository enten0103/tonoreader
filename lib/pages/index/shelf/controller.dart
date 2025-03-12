import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class ShelfController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  List<Widget> tabs = [
    const Tab(
      text: "本地",
    ),
    const Tab(
      text: "收藏",
    ),
    const Tab(
      text: "历史",
    )
  ];
  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
