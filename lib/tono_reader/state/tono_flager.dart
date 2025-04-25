import 'package:get/state_manager.dart';
import 'package:voidlord/utils/type.dart';

class TonoFlager extends GetxController {
  RxBool isStateVisible = false.obs; // 控制工具栏的显示状态
  var state = LoadingState.loading.obs;
  RxBool paging = true.obs;
}
