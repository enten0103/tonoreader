import 'package:file_picker/file_picker.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:voidlord/routes/void_routers.dart';

class TestController extends GetxController {
  static void addFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["epub"]);
    var file = result?.files.first;
    Get.toNamed(VoidRouters.readerPage,
        parameters: {'path': file!.path!, 'type': 'local'});
  }
}
