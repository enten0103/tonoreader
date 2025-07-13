import 'package:get/get.dart';
import 'package:voidlord/pages/auth/register/controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
