import 'package:get/get.dart';
import 'package:voidlord/pages/index/controller.dart';
import 'package:voidlord/pages/index/home/controller.dart';
import 'package:voidlord/pages/index/shelf/controller.dart';
import 'package:voidlord/pages/index/shelf/subpage/local/controller.dart';

class IndexBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ShelfController());
    Get.lazyPut(() => LocalShelfPageController());
  }
}
