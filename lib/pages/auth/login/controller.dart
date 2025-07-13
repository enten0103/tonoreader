import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:voidlord/api/auth_api.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/controller/auth_controller.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      if (username.isEmpty || password.isEmpty) {
        errorMessage.value = "用户名和密码不能为空";
        return;
      }
      Api api = Get.find();
      AuthController authController = Get.find();
      var token = await api.login(username, password);
      authController.token = token;
    } catch (e) {
      errorMessage.value = "账号或密码错误";
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
