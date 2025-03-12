import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:voidlord/pages/index/shelf/controller.dart';
import 'package:voidlord/pages/index/shelf/subpage/collect/view.dart';
import 'package:voidlord/pages/index/shelf/subpage/history/view.dart';
import 'package:voidlord/pages/index/shelf/subpage/local/view.dart';

class ShelfPage extends StatelessWidget {
  const ShelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    var shelfController = Get.find<ShelfController>();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.shelves),
        title: Text("书架"),
        actions: [
          SizedBox(
              width: 150,
              child: TabBar(
                tabs: shelfController.tabs,
                controller: shelfController.tabController,
                isScrollable: false,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
              ))
        ],
      ),
      body: TabBarView(
        controller: shelfController.tabController,
        children: [
          LocalShelfPage(),
          CollectShelfPage(),
          HistoryShelfPage(),
        ],
      ),
    );
  }
}
