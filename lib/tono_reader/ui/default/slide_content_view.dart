import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/controller.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/render/widget/tono_outer_widget.dart';
import 'package:voidlord/tono_reader/ui/default/water_mark.dart';

class SlideContentView extends StatelessWidget {
  const SlideContentView({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<TonoReaderController>();
    var config = Get.find<TonoReaderConfig>();
    var border = config.viewPortConfig;
    return GestureDetector(
        onTap: () => controller.onBodyClick(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                width: Get.size.width,
                height: border.top,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Align(
                            child: Container(
                          width: Get.size.width - border.left - border.right,
                          height: 20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(216, 216, 216, 1),
                                blurRadius: 12,
                                spreadRadius: 1,
                                offset: Offset(0, -6),
                              ),
                            ],
                            // 添加渐变过渡（可选）
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                const Color.fromARGB(204, 255, 255, 255),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ))),
                    Container(
                      width: Get.size.width,
                      height: border.bottom,
                      color: Get.theme.colorScheme.surface,
                    )
                  ],
                )),
            SizedBox(
                height: Get.size.height - border.top - border.bottom,
                width: Get.size.width,
                child: TonoOuterWidget(
                  root: controller.tonoDataProvider.widgets[0] as TonoContainer,
                )),
            SizedBox(
                width: Get.size.width,
                height: border.bottom,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Align(
                            child: Container(
                          width: Get.size.width - border.left - border.right,
                          height: 20,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(216, 216, 216, 1),
                                blurRadius: 12,
                                spreadRadius: 1,
                                offset: Offset(0, 6),
                              ),
                            ],
                            // 添加渐变过渡（可选）
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                const Color.fromARGB(204, 255, 255, 255),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ))),
                    Container(
                      width: Get.size.width,
                      height: border.bottom,
                      color: Get.theme.colorScheme.surface,
                      child: WaterMark(),
                    )
                  ],
                )),
          ],
        ));
  }
}
