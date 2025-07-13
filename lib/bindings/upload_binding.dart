import 'package:get/get.dart';
import 'package:voidlord/pages/upload/controller.dart';

class UploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UploadController());
  }
}
