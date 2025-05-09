import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/tono_reader/tool/tono_serializer.dart';

class ParseBookDialogController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ParseBookDialogController({required this.filePath});
  String filePath;
  RxInt current = 0.obs;
  RxInt total = 0.obs;
  RxString info = "".obs;
  @override
  void onReady() async {
    super.onReady();
    var parser = await TonoParser.initFormDisk(filePath, (e) async {
      await Future.delayed(Duration(milliseconds: 100));
      info.value = e.info;
      current.value = e.currentIndex;
      total.value = e.totalIndex;
    });
    var tono = await parser.parse();
    await TonoSerializer.save(tono);
    await Future.delayed(Duration(milliseconds: 200));
    Get.back();
  }
}

class ParseBookDialog extends StatelessWidget {
  const ParseBookDialog({
    required this.filePath,
    super.key,
  });
  final String filePath;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ParseBookDialogController(filePath: filePath));
    return Obx(() => Dialog(
        elevation: 19,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: Get.mediaQuery.size.width,
              maxHeight: 100,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            "正在解析:${controller.info.value}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          Text(
                              " ${controller.current.value + 1}/${controller.total.value}")
                        ])),
                SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 0,
                      ),
                    ),
                    child: Obx(() {
                      return Slider(
                        value: controller.current.value.toDouble(),
                        min: 0,
                        max: controller.total.value.toDouble(),
                        onChanged: (_) {},
                      );
                    }))
              ],
            ))));
  }
}
