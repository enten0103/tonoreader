import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:voidlord/api/auth_api.dart';
import 'package:voidlord/api/index.dart';

class RegisterController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isRegistering = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool agreeToTerms = false.obs;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> register(String username, String email, String password) async {
    try {
      isLoading.value = true;
      isRegistering.value = true;
      errorMessage.value = '';
      Api api = Get.find<Api>();
      await api.register(username, email, password);
      isRegistering.value = false;
    } catch (e) {
      print(e.toString());
      errorMessage.value = e.toString();
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
