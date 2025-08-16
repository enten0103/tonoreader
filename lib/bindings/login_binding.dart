import 'package:get/get.dart';
import 'package:voidlord/pages/auth/login/controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // 使用 fenix: true，避免返回登录页时复用已被 onClose() 里 dispose 的 TextEditingController
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}
