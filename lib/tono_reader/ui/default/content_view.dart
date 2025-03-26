import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/state/tono_progresser.dart';

class ContentView extends StatelessWidget {
  const ContentView({
    super.key,
    required this.widget,
    required this.onDoubleTap,
    required this.onTap,
  });

  final Widget widget;

  final Function onTap;

  final Function onDoubleTap;

  @override
  Widget build(BuildContext context) {
    TonoProgresser tonoProgresser = Get.find<TonoProgresser>();
    var config = Get.find<TonoReaderConfig>();
    var border = config.viewPortConfig;
    return GestureDetector(
        onTap: () {
          onTap();
        },
        behavior: HitTestBehavior.opaque,
        onDoubleTapDown: (details) {
          onDoubleTap(details);
        },
        child: Padding(
            key: Key(tonoProgresser.xhtmlIndex.toString()),
            padding: EdgeInsetsDirectional.fromSTEB(
                border.left, border.top, border.right, border.bottom),
            child: SafeArea(
                child: SizedBox.expand(
                    child:
                        Align(alignment: Alignment.topLeft, child: widget)))));
  }
}
