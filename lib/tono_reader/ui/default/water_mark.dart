import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/state/tono_progresser.dart';
import 'package:voidlord/tono_reader/tool/clock.dart';

class WaterMark extends StatelessWidget {
  const WaterMark({super.key});

  @override
  Widget build(BuildContext context) {
    var progressor = Get.find<TonoProgresser>();
    var config = Get.find<TonoReaderConfig>();
    return Padding(
        padding: EdgeInsets.only(
            left: config.viewPortConfig.left,
            right: config.viewPortConfig.right),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Clock(),
          Obx(() => Text(
                "${((progressor.currentElementIndex.value + 1) / progressor.totalElementCount * 100).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF999999),
                ),
              )),
        ]));
  }
}
