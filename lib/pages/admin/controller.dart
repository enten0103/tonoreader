import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/api/permission_api.dart';
import 'package:voidlord/controller/auth_controller.dart';
import 'package:voidlord/model/dto/permission_dto.dart';
import 'package:voidlord/pages/admin/permissions/permissionsmgmt/view.dart';
import 'package:voidlord/pages/admin/permissions/usermgmt/view.dart';

class AdminController extends GetxController {
  final permissions = <UserPermission>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // 侧边栏/抽屉 选中索引（0: 权限，1: 用户管理）
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadPermissions();
    // 当权限变化时，确保选中索引在有效范围内
    ever<List<UserPermission>>(permissions, (_) => _ensureIndexInRange());
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

  /// 是否拥有任一等级为大于等于2的权限
  bool get hasLevel3 => permissions.any((p) => p.level >= 2);

  /// 目的地数量：始终包含“权限”，如有 level3 则包含“用户管理”
  int get destinationCount => hasLevel3 ? 2 : 1;

  void onDestinationSelected(int index) {
    if (index == 1 && !hasLevel3) {
      selectedIndex.value = 0;
    } else {
      selectedIndex.value = index;
    }
  }

  void _ensureIndexInRange() {
    if (selectedIndex.value >= destinationCount) {
      selectedIndex.value = 0;
    }
  }

  List<AdminDestinationItem> get destinations {
    final items = <AdminDestinationItem>[
      const AdminDestinationItem(
        label: '权限',
        icon: Icons.verified_user_outlined,
        page: PermissionsTab(),
      ),
    ];
    if (hasLevel3) {
      items.add(const AdminDestinationItem(
        label: '用户管理',
        icon: Icons.group_outlined,
        page: UsersManagePage(),
      ));
    }
    return items;
  }

  Widget get currentBody {
    final list = destinations;
    final idx = selectedIndex.value.clamp(0, list.length - 1);
    return list[idx].page;
  }
}

class AdminDestinationItem {
  final String label;
  final IconData icon;
  final Widget page;
  const AdminDestinationItem(
      {required this.label, required this.icon, required this.page});
}
