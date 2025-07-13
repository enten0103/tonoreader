import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:voidlord/pages/upload/controller.dart';

class UploadPage extends GetView<UploadController> {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("上传"),
      ),
      body: Obx(() => ListView.builder(
          itemBuilder: (ctx, index) {
            return ListTile(
              title: Text(controller.bookUploads[index].title),
              subtitle: Text(DateFormat("yyyy-MM-dd HH:mm")
                  .format(controller.bookUploads[index].createdAt)),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => {},
              ),
              onTap: () {},
            );
          },
          itemCount: controller.bookUploads.length,
          padding: const EdgeInsets.all(8.0))),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.uploadFile,
        child: const Icon(Icons.add),
      ),
    );
  }
}
