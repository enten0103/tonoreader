import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/model/base/tono_location.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/state/tono_user_data_provider.dart';
import 'package:voidlord/tono_reader/tool/tono_container_stringify.dart';

class OpDialogView extends StatelessWidget {
  const OpDialogView(
      {super.key,
      required this.index,
      required this.location,
      required this.isMarked});

  final int index;
  final TonoLocation location;
  final RxBool isMarked;

  @override
  Widget build(BuildContext context) {
    var provider = Get.find<TonoProvider>();
    var userData = Get.find<TonoUserDataProvider>();
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
              "${location.xhtmlIndex} ${location.elementIndex}",
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
                IconButton(onPressed: () {
                  isMarked.value = !isMarked.value;
                  if (isMarked.value == true) {
                    userData.bookmarks.add(location);
                  } else {
                    userData.bookmarks.removeWhere((e) {
                      return e.elementIndex == location.elementIndex &&
                          e.xhtmlIndex == location.xhtmlIndex;
                    });
                  }
                }, icon: Obx(() {
                  if (isMarked.value) {
                    return Icon(Icons.bookmark_added);
                  } else {
                    return Icon(Icons.bookmark_add_outlined);
                  }
                })),
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
