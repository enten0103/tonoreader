// import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:voidlord/api/book_api.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/model/book_upload.dart';
import 'package:voidlord/routes/void_routers.dart';
// import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/utils/list_tool.dart';

class UploadController extends GetxController {
  RxList<BookUploadModule> bookUploads = <BookUploadModule>[].obs;

  Api api = Get.find();

  init() async {
    List<BookUploadModule> uploads = await api.listUpload();
    uploads.merge(bookUploads, (a, b) => a.id == b.id);
  }

  void uploadFile() async {
    Get.toNamed(VoidRouters.bookUploadDetailPage);
    // FilePickerResult? result = await FilePicker.platform
    //     .pickFiles(type: FileType.custom, allowedExtensions: ["epub"]);
    // var file = result?.files.first;
    // var filePath = file!.path!;
    // var parser = await TonoParser.initFormDisk(filePath, (e) async {});
    // var tono = await parser.parse();
    // try {
    //   await api.createUpload(tono.bookInfo.title, tono.hash);
    //   Get.snackbar("上传成功", "书籍已成功上传",
    //       snackPosition: SnackPosition.BOTTOM,
    //       duration: const Duration(seconds: 3),
    //       backgroundColor: Get.theme.colorScheme.primaryContainer,
    //       colorText: Get.theme.colorScheme.onPrimaryContainer);
    //   await init();
    // } catch (e) {
    //   Get.snackbar("上传失败", e.toString(),
    //       snackPosition: SnackPosition.BOTTOM,
    //       duration: const Duration(seconds: 3),
    //       backgroundColor: Get.theme.colorScheme.errorContainer,
    //       colorText: Get.theme.colorScheme.onErrorContainer);
    //   rethrow;
    // }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
