import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/controller.dart';
import 'package:voidlord/tono_reader/model/base/tono_type.dart';
import 'package:voidlord/tono_reader/ui/default/bottom_bar_view.dart';
import 'package:voidlord/tono_reader/ui/default/content_view.dart';
import 'package:voidlord/tono_reader/ui/default/top_bar_view.dart';
import 'package:voidlord/utils/type.dart';

class TonoReader extends StatelessWidget {
  const TonoReader({
    super.key,
    required this.filePath,
    required this.tonoType,
  });
  final String filePath;
  final TonoType tonoType;

  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put(TonoReaderController(filePath: filePath, tonoType: tonoType));
    return Obx(() => Scaffold(
          key: controller.scaffoldKey,
          body: Stack(
            children: [
              // 阅读内容，固定大小
              Positioned.fill(
                  child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: switch (controller.state.value) {
                        LoadingState.loading => _buildLoading(),
                        LoadingState.failed => _buildFailed(),
                        LoadingState.success => ContentView(
                            widgets: controller.currentWidgets,
                            onTap: () {
                              controller.onBodyClick();
                            },
                          )
                      })),
              // AppBar 的滑动动画
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: AnimatedSlide(
                    offset: controller.isStateVisible.value
                        ? Offset(0, 0)
                        : Offset(0, -1), // 从顶部滑出
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: TopBarView(
                        bookTitle: controller.tono?.bookInfo.title ?? "")),
              ),
              // 底部操作栏的滑动动画
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedSlide(
                  offset: controller.isStateVisible.value
                      ? Offset(0, 0)
                      : Offset(0, 1), // 从底部滑出
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: BottomBarView(
                    onMenuBtnPress: () {
                      controller.openNavDrawer();
                    },
                  ),
                ),
              ),
            ],
          ),
          drawer: Drawer(
            child: SizedBox(
              height: 200,
              child: Text("124"),
            ),
          ),
        ));
  }

  Widget _buildLoading() {
    return Text("loading");
  }

  Widget _buildFailed() {
    return Text("failed");
  }
}
