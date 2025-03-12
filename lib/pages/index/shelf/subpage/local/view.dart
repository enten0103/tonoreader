import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:logger/logger.dart';
import 'package:voidlord/componets/book_cover.dart';
import 'package:voidlord/pages/index/shelf/subpage/local/controller.dart';
import 'package:voidlord/routes/void_routers.dart';

class LocalShelfPage extends StatelessWidget {
  const LocalShelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    var log = Get.find<Logger>();
    var localShelfPageController = Get.find<LocalShelfPageController>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Obx(() => Wrap(
              children: localShelfPageController.bookLocalModels.map((x) {
                return Column(children: [
                  BookCover(
                    id: x.id,
                    url: x.coverUrl,
                    onTap: () {
                      Get.toNamed(VoidRouters.readerPage,
                          arguments: "local/${x.id}");
                    },
                  ),
                  SizedBox(
                    width: 110,
                    child: Text(
                      x.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ]);
              }).toList(),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          try {
            LocalShelfPageController.addFile();
          } catch (e) {
            log.w(e.toString());
          }
        },
      ),
    );
  }
}
