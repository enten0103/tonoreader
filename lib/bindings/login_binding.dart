import 'package:get/get.dart';
import 'package:voidlord/pages/auth/login/controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
