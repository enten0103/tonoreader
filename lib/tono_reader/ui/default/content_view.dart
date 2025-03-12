import 'package:flutter/widgets.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:voidlord/tono_reader/config.dart';

class ContentView extends StatelessWidget {
  const ContentView({
    super.key,
    required this.widgets,
    required this.onTap,
  });

  final List<Widget> widgets;

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var config = Get.find<TonoReaderConfig>();
    var border = config.viewPortConfig;
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                border.left, border.top, border.right, border.bottom),
            child: ListView.builder(
                cacheExtent: 2000.0,
                itemCount: widgets.length,
                itemBuilder: (ctx, index) {
                  return widgets[index];
                })));
  }
}
