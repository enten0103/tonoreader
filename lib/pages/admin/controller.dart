import 'package:get/get.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/api/permission_api.dart';
import 'package:voidlord/controller/auth_controller.dart';
import 'package:voidlord/model/dto/permission_dto.dart';

class AdminController extends GetxController {
  final permissions = <UserPermission>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPermissions();
  }

  Future<void> loadPermissions() async {
    errorMessage.value = '';
    final auth = Get.find<AuthController>();
    final user = auth.user.value;
    if (user == null) {
      permissions.clear();
      return;
    }
    try {
      isLoading.value = true;
      final api = Get.find<Api>();
      final list = await api.getUserPermissions(user.id);
      // 排序：按权限名
      list.sort((a, b) => a.permission.compareTo(b.permission));
      permissions.assignAll(list);
    } catch (e) {
      errorMessage.value = '加载权限失败';
    } finally {
      isLoading.value = false;
    }
  }
}
