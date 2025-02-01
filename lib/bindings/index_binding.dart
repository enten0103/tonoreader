import 'package:get/get.dart';
import 'package:voidlord/pages/index/controller.dart';
import 'package:voidlord/pages/index/home/controller.dart';

class IndexBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => HomeController());
  }
}
