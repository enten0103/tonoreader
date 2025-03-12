import 'package:get/instance_manager.dart';
import 'package:voidlord/pages/search_pre/controller.dart';

class SearchPreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchPreController());
  }
}
