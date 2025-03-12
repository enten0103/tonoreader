import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/componets/loading_block.dart';
import 'package:voidlord/model/book_block.dart';
import 'package:voidlord/pages/index/home/componets/item_block.dart';
import 'package:voidlord/pages/index/home/controller.dart';
import 'package:voidlord/routes/void_routers.dart';
import 'package:voidlord/utils/type.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Get.theme.colorScheme.surface,
        backgroundColor: Get.theme.colorScheme.surface,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 20),
                Expanded(
                  child: FractionallySizedBox(
                    heightFactor: 0.9,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        onPressed: () {
                          Get.toNamed(VoidRouters.searchPrePage);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(Icons.search)),
                        )),
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
      body: Obx(() {
        return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: switch (homeController.loadingState.value) {
              LoadingState.loading => _buildLoading(),
              LoadingState.failed => _buildFailed(),
              LoadingState.success => _buildSuccess(homeController.bookBlocks)
            });
      }),
    );
  }

  Widget _buildLoading() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              LoadingBlock(height: 40),
              SizedBox(
                height: 10,
              ),
              LoadingBlock(height: 160),
              SizedBox(
                height: 20,
              ),
              LoadingBlock(height: 40),
              SizedBox(
                height: 10,
              ),
              LoadingBlock(height: 160),
              SizedBox(
                height: 20,
              ),
              LoadingBlock(height: 40),
              SizedBox(
                height: 10,
              ),
              LoadingBlock(height: 160),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuccess(List<BookBlockModel> bookBlocks) {
    return ListView.builder(
        itemCount: bookBlocks.length,
        itemBuilder: (_, index) {
          return ItemBlock(bookBlockModel: bookBlocks[index]);
        });
  }

  Widget _buildFailed() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.error),
        Text("加载失败"),
      ],
    ));
  }
}
