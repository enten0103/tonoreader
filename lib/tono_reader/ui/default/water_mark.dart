import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/state/tono_progresser.dart';

class WaterMark extends StatelessWidget {
  const WaterMark({super.key});

  @override
  Widget build(BuildContext context) {
    var progressor = Get.find<TonoProgresser>();
    return Obx(() => Text(
          "${((progressor.currentElementIndex.value + 1) / progressor.totalElementCount * 100).toStringAsFixed(1)}%",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF999999),
          ),
        ));
  }
}
