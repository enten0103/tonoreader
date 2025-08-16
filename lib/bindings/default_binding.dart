import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/controller/auth_controller.dart';
import 'package:voidlord/repo/database.dart';

class DefaultBinding {
  Future<void> dependencies() async {
    await Get.putAsync(() async => await AppDatabase.getInstance());
    await Get.putAsync(() async => await SharedPreferences.getInstance());
    Get.lazyPut(() => Api());
    Get.lazyPut(() => Logger());
    Get.lazyPut(() => AuthController());
  }
}
