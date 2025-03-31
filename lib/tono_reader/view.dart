import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/controller.dart';
import 'package:voidlord/tono_reader/model/base/tono_type.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/state/tono_flager.dart';
import 'package:voidlord/tono_reader/ui/default/bottom_bar_view.dart';
import 'package:voidlord/tono_reader/ui/default/content_view.dart';
import 'package:voidlord/tono_reader/ui/default/paging_view.dart';
import 'package:voidlord/tono_reader/ui/default/top_bar_view.dart';
import 'package:voidlord/utils/type.dart';

class TonoReader extends StatelessWidget {
  const TonoReader({
    super.key,
    required this.id,
    required this.tonoType,
  });
  final String id;
  final TonoType tonoType;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TonoReaderController(id: id, tonoType: tonoType));
    var flager = Get.put(TonoFlager());

    var dataProvoder = Get.put(TonoProvider());
    return Obx(() => Scaffold(
          key: flager.scaffoldKey,
          body: Stack(
            children: [
              // 阅读内容，固定大小
              Positioned.fill(
                  child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: switch (flager.state.value) {
                        LoadingState.loading => _buildLoading(),
                        LoadingState.failed => _buildFailed(),
                        LoadingState.success =>
                          _buildSuccess(controller, flager)
                      })),
              // AppBar 的滑动动画
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: AnimatedSlide(
                    offset: flager.isStateVisible.value
                        ? Offset(0, 0)
                        : Offset(0, -1), // 从顶部滑出
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: TopBarView(bookTitle: dataProvoder.title)),
              ),
              // 底部操作栏的滑动动画
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedSlide(
                  offset: flager.isStateVisible.value
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
        ));
  }

  Widget _buildSuccess(TonoReaderController controller, TonoFlager flager) {
    return Obx(() {
      return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: flager.paging.value
              ? PagingView()
              : ContentView(
                  onTap: () {
                    controller.onBodyClick();
                  },
                  onDoubleTap: (detail) {
                    controller.siblingChapter(detail);
                  },
                ));
    });
  }

  Widget _buildLoading() {
    return Text("loading");
  }

  Widget _buildFailed() {
    return Text("failed");
  }
}
