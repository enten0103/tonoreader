import 'package:get/get.dart';
import 'package:voidlord/pages/detail/controller.dart';

class BookDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookDetailController());
  }
}
