import 'package:get/get.dart';
import 'package:voidlord/pages/upload/detail/controller.dart';

class BookUploadDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UploadDetailController());
  }
}
