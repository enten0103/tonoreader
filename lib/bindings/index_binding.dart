import 'package:get/get.dart';
import 'package:voidlord/controller/auth_controller.dart';
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
    // 应用进入首页时，如果已有 token 和用户信息，刷新一次权限
    final auth = Get.find<AuthController>();
    // on first binding, try check permissions if we already logged in before
    auth.checkPermissions();
  }
}
