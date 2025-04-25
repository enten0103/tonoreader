import 'package:flutter/cupertino.dart';
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  border.left, border.top, border.left, border.bottom),
              child: SafeArea(
                  child: TonoOuterWidget(
                key: ValueKey("outer"),
                root: controller.tonoDataProvider.widgets[0] as TonoContainer,
              )),
            ),
            Positioned(
                bottom: border.bottom, right: border.right, child: WaterMark()),
          ],
        ));
  }
}
