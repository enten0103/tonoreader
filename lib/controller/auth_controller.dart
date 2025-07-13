import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  set token(String token) {
    SharedPreferences preferences = Get.find();
    preferences.setString('auth_token', token);
  }

  String get token {
    SharedPreferences preferences = Get.find();
    return preferences.getString('auth_token') ?? '';
  }
}
