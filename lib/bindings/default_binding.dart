import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/repo/database.dart';

class DefaultBing implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => Api());
    Get.lazyPut(() => Logger());
    await Get.putAsync(() => AppDatabase.getInstance());
    await Get.putAsync(() => SharedPreferences.getInstance());
  }
}
