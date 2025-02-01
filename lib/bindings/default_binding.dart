import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:voidlord/api/index.dart';

class DefaultBing implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Api());
  }
}
