// controller.dart
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/model/book_info.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/utils/type.dart';

class UploadDetailController extends GetxController {
  final loadingState = LoadingState.loading.obs;
  final bookInfoModel = BookInfoModel(id: '', coverUrl: '', title: '').obs;
  final id = "".obs;
  late Tono tono;

  // 表单控制器
  final formKey = GlobalKey<FormState>();
  late TextEditingController idController;
  late TextEditingController titleController;
  late TextEditingController coverUrlController;
  late TextEditingController subTitleController;
  late TextEditingController ssubTitleController;

  @override
  void onInit() async {
    super.onInit();

    idController = TextEditingController();
    titleController = TextEditingController();
    coverUrlController = TextEditingController();
    subTitleController = TextEditingController();
    ssubTitleController = TextEditingController();

    id.value = Get.arguments?['id'] ?? "";

    try {
      if (id.value.isEmpty) {
        await initFromEmpty();
      } else {
        await initFromNet();
      }
      loadingState.value = LoadingState.success;
    } catch (e) {
      loadingState.value = LoadingState.failed;
      showErrorSnackbar("加载失败", e.toString());
    }
  }

  @override
  void onClose() {
    idController.dispose();
    titleController.dispose();
    coverUrlController.dispose();
    subTitleController.dispose();
    ssubTitleController.dispose();
    super.onClose();
  }

  void showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: Get.theme.colorScheme.errorContainer,
      colorText: Get.theme.colorScheme.onErrorContainer,
    );
  }

  void retryLoading() {
    loadingState.value = LoadingState.loading;
    onInit();
  }

  Future<void> initFromNet() async {
    _updateControllers();
  }

  Future<void> initFromEmpty() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["epub"],
    );

    if (result == null || result.files.isEmpty) {
      throw Exception("未选择文件");
    }

    var file = result.files.first;
    var filePath = file.path!;
    var parser = await TonoParser.initFormDisk(filePath, (e) async {});
    tono = await parser.parse();

    bookInfoModel.value = BookInfoModel(
      id: tono.hash,
      title: tono.bookInfo.title,
      coverUrl: tono.bookInfo.coverUrl,
      subTitle: null,
      ssubTitle: null,
    );

    _updateControllers();
  }

  void _updateControllers() {
    idController.text = bookInfoModel.value.id;
    titleController.text = bookInfoModel.value.title;
    coverUrlController.text = bookInfoModel.value.coverUrl;
    subTitleController.text = bookInfoModel.value.subTitle ?? "";
    ssubTitleController.text = bookInfoModel.value.ssubTitle ?? "";
  }

  void updateTitle(String value) {
    bookInfoModel.update((model) {
      model?.title = value;
    });
  }

  void updateCoverUrl(String value) {
    bookInfoModel.update((model) {
      model?.coverUrl = value;
    });
  }

  void updateSubTitle(String value) {
    bookInfoModel.update((model) {
      model?.subTitle = value;
    });
  }

  void updateSSubTitle(String value) {
    bookInfoModel.update((model) {
      model?.ssubTitle = value;
    });
  }

  Future<void> pickCoverImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      String? path = result.files.single.path;
      if (path != null) {
        coverUrlController.text = path;
        updateCoverUrl(path);
      }
    }
  }

  void saveChanges() {
    if (formKey.currentState?.validate() ?? false) {
      // 保存逻辑
      Get.snackbar(
        "保存成功",
        "书籍信息已更新",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }
}
