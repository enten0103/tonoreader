import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/pages/index/home/componets/item_block.dart';
import 'package:voidlord/pages/index/home/controller.dart';
import 'package:voidlord/pages/index/home/module.dart';
import 'package:voidlord/utils/type.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    return Obx(() {
      return switch (homeController.loadingState.value) {
        LoadingState.loading => _buildLoading(),
        LoadingState.failed => _buildFailed(),
        LoadingState.success => _buildSuccess(homeController.bookBlocks)
      };
    });
  }

  Widget _buildLoading() {
    return Text("loading");
  }

  Widget _buildSuccess(List<BookBlockModule> bookBlocks) {
    return ListView.builder(
        itemCount: bookBlocks.length,
        itemBuilder: (_, index) {
          return ItemBlock(bookBlockModule: bookBlocks[index]);
        });
  }

  Widget _buildFailed() {
    return Text("failed");
  }
}
