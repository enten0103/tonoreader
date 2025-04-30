import 'package:get/state_manager.dart';
import 'package:voidlord/utils/type.dart';

/// 标志器
class TonoFlager extends GetxController {
  RxBool isStateVisible = false.obs;
  var state = LoadingState.loading.obs;
  RxBool paging = true.obs;
}
