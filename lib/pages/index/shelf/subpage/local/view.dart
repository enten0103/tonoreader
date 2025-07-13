import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:logger/logger.dart';
import 'package:voidlord/components/book_cover.dart';
import 'package:voidlord/pages/index/shelf/subpage/local/controller.dart';
import 'package:voidlord/routes/void_routers.dart';

class LocalShelfPage extends StatelessWidget {
  const LocalShelfPage({super.key});

  @override
  Widget build(BuildContext context) {
    var log = Get.find<Logger>();
    var localShelfPageController = Get.find<LocalShelfPageController>();
    var width = (Get.mediaQuery.size.width - 40) / 3;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Obx(() => GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: width / 220,
                  children: localShelfPageController.bookLocalModels.map((x) {
                    return PhysicalModel(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onLongPress: () {
                              localShelfPageController.delete(x.id);
                            },
                            onTap: () {
                              Future.delayed(Duration(milliseconds: 200), () {
                                Get.toNamed(VoidRouters.readerPage,
                                    parameters: {
                                      "id": x.id,
                                      "type": "local",
                                    });
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(children: [
                                  BookCover(
                                    id: x.id,
                                    url: x.coverUrl,
                                  ),
                                  Container(
                                    constraints: BoxConstraints(maxWidth: 110),
                                    child: Text(
                                      x.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ]))));
                  }).toList(),
                )),
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          try {
            localShelfPageController.addFile();
          } catch (e) {
            log.w(e.toString());
          }
        },
      ),
    );
  }
}
