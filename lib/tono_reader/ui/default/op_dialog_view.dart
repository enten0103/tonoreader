import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/tool/tono_container_stringify.dart';

class OpDialogView extends StatelessWidget {
  const OpDialogView({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    var provider = Get.find<TonoProvider>();
    return Dialog(
      elevation: 19,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 200,
          minWidth: Get.mediaQuery.size.width,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              "操作",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Container(
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 200),
                  width: double.infinity,
                  child: SelectableText(
                    provider.getWidgetByElementCount(index).stringify(),
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(0, 0, 0, 0.5)),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.g_translate_outlined)),
                IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_added)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.edit_note_outlined)),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.copy_all_outlined)),
                SizedBox(
                  width: 12,
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
