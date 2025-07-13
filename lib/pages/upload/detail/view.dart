// upload_detail_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/components/book_info.dart';
import 'package:voidlord/pages/upload/detail/controller.dart';
import 'package:voidlord/tono_reader/tool/async_memory_image.dart';
import 'package:voidlord/tono_reader/widget_provider/local_tono_widget_provider.dart';
import 'package:voidlord/utils/tono_uploader.dart';
import 'package:voidlord/utils/type.dart';

class UploadDetailPage extends GetView<UploadDetailController> {
  const UploadDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('书籍简介编辑'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Obx(() {
          switch (controller.loadingState.value) {
            case LoadingState.loading:
              return const Center(child: CircularProgressIndicator());
            case LoadingState.failed:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('解析失败', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.retryLoading,
                      child: const Text('重试'),
                    ),
                  ],
                ),
              );
            case LoadingState.success:
              return _buildEditForm();
          }
        }),
      ),
    );
  }

  Widget _buildEditForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 封面预览
          _buildCoverPreview(),
          const SizedBox(height: 24),

          _buildFormFields(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildCoverPreview() {
    return Obx(() => Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: controller.bookInfoModel.value.coverUrl.isNotEmpty
                  ? BookInfo(
                      bookInfoModel: controller.bookInfoModel.value,
                      image: Image(
                        image: AsyncMemoryImage(
                          controller.tono.widgetProvider.getAssetsById(
                              controller.bookInfoModel.value.coverUrl),
                          '${controller.bookInfoModel.value.id}.${controller.bookInfoModel.value.coverUrl}',
                        ),
                      ))
                  : Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image, size: 60, color: Colors.grey),
                      ),
                    ),
            ),
          ),
        ));
  }

  Widget _buildFormFields() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ID字段（只读）
          TextFormField(
            controller: controller.idController,
            decoration: const InputDecoration(
              labelText: '书籍ID',
              border: OutlineInputBorder(),
              filled: true,
              prefixIcon: Icon(Icons.fingerprint),
            ),
            readOnly: true,
          ),
          const SizedBox(height: 16),

          // 标题字段
          TextFormField(
            controller: controller.titleController,
            decoration: const InputDecoration(
              labelText: '标题*',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入标题';
              }
              return null;
            },
            onChanged: (value) => controller.updateTitle(value),
          ),
          const SizedBox(height: 16),

          // 副标题字段
          TextFormField(
            controller: controller.subTitleController,
            decoration: const InputDecoration(
              labelText: '副标题',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.subtitles),
            ),
            onChanged: (value) => controller.updateSubTitle(value),
          ),
          const SizedBox(height: 16),

          // 次副标题字段
          TextFormField(
            controller: controller.ssubTitleController,
            decoration: const InputDecoration(
              labelText: '次副标题',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.text_fields),
            ),
            onChanged: (value) => controller.updateSSubTitle(value),
          ),
          ElevatedButton(
              onPressed: () {
                (controller.tono.widgetProvider as LocalTonoWidgetProvider)
                    .upload();
              },
              child: Text("测试"))
        ],
      ),
    );
  }
}
