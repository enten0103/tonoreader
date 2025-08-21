import 'package:get/get.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/api/user_api.dart';
import 'package:voidlord/api/permission_api.dart';
import 'package:voidlord/model/dto/user_dto.dart';
import 'package:voidlord/model/dto/permission_dto.dart';
import 'package:voidlord/pages/admin/controller.dart';

class UsersManageController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final users = <User>[].obs;

  // 搜索与筛选状态
  final keyword = ''.obs; // 用户名/邮箱包含
  final showWithEmailOnly = false.obs; // 仅显示有邮箱的

  @override
  void onInit() {
    super.onInit();
    load();
    //响应式
    everAll([keyword, showWithEmailOnly], (_) => applyFilter());
  }

  Future<void> load() async {
    errorMessage.value = '';
    try {
      isLoading.value = true;
      final api = Get.find<Api>();
      final list = await api.listUsers();
      users.assignAll(list);
      applyFilter();
    } catch (e) {
      errorMessage.value = '加载用户失败';
    } finally {
      isLoading.value = false;
    }
  }

  // 过滤后的结果（派生）
  final filtered = <User>[].obs;

  void applyFilter() {
    final kw = keyword.value.trim().toLowerCase();
    final withEmail = showWithEmailOnly.value;

    var list = users;
    if (kw.isNotEmpty) {
      list = list
          .where((u) =>
              u.username.toLowerCase().contains(kw) ||
              (u.email?.toLowerCase().contains(kw) ?? false))
          .toList()
          .obs;
    }
    if (withEmail) {
      list = list.where((u) => (u.email ?? '').isNotEmpty).toList().obs;
    }
    filtered.assignAll(list);
  }

  // ---- 用户权限弹窗逻辑 ----
  final targetUser = Rxn<User>();
  final targetPermissions = <UserPermission>[].obs;
  final isPermLoading = false.obs;
  final permError = ''.obs;
  final saving = false.obs;
  // 待提交变更：permission -> level
  final pending = <String, int>{}.obs;

  Future<void> openPermissionSheet(User user) async {
    targetUser.value = user;
    pending.clear();
    await loadTargetPermissions();
  }

  Future<void> loadTargetPermissions() async {
    permError.value = '';
    final u = targetUser.value;
    if (u == null) return;
    try {
      isPermLoading.value = true;
      final api = Get.find<Api>();
      final list = await api.getUserPermissions(u.id);
      targetPermissions.assignAll(list);
    } catch (e) {
      permError.value = '加载权限失败';
    } finally {
      isPermLoading.value = false;
    }
  }

  int getPermissionLevel(String permission) {
    // 优先显示待提交的覆盖值：直接读取 pending[permission] 以建立依赖
    final override = pending[permission];
    if (override != null) return override;
    final p =
        targetPermissions.firstWhereOrNull((e) => e.permission == permission);
    return p?.level ?? 0;
  }

  // 仅更新待提交变更，不立即请求后端
  void setPendingLevel({
    required String permission,
    required int level,
  }) {
    // 基于当前操作者 USER_UPDATE 等级限制（UI 层也会限制，这里再兜底）
    final allowed = allowedLevelsFor(permission);
    if (!allowed.contains(level)) {
      Get.snackbar('无权限', '你无权将 $permission 设置为 $level 级');
      return;
    }
    // 与当前后端值一致则移除 pending
    final current = targetPermissions
            .firstWhereOrNull((e) => e.permission == permission)
            ?.level ??
        0;
    if (level == current) {
      pending.remove(permission);
    } else {
      pending[permission] = level;
    }
    pending.refresh();
  }

  Future<void> submitPending() async {
    final u = targetUser.value;
    if (u == null) return;
    if (pending.isEmpty) return;
    saving.value = true;
    final api = Get.find<Api>();
    final failures = <String>[];
    try {
      // 顺序提交每一项
      for (final entry in pending.entries) {
        final permission = entry.key;
        final level = entry.value;
        // 再次权限校验
        final allowed = allowedLevelsFor(permission);
        if (!allowed.contains(level)) {
          failures.add('$permission: 无权限设置为 $level');
          continue;
        }
        try {
          if (level <= 0) {
            await api.revokePermission(userId: u.id, permission: permission);
          } else {
            await api.grantPermission(
                userId: u.id, permission: permission, level: level);
          }
        } catch (e) {
          failures.add('$permission: 提交失败');
        }
      }
      // 刷新后端状态
      await loadTargetPermissions();
      // 清空待提交
      pending.clear();
      if (failures.isEmpty) {
        Get.snackbar('已提交', '权限变更已生效');
      } else {
        Get.snackbar('部分失败', failures.join('\n'));
      }
    } finally {
      saving.value = false;
    }
  }

  // ---- 当前操作者权限判断 ----
  int myLevelFor(String permission) {
    final admin = Get.find<AdminController>();
    final p =
        admin.permissions.firstWhereOrNull((e) => e.permission == permission);
    return p?.level ?? 0;
  }

  /// 返回可设置的等级集合（按 USER_UPDATE 等级）：
  /// <2: []；=2: [0,1]；>=3: [0,1,2,3]
  List<int> allowedLevelsFor(String permission) {
    final lv = myLevelFor('USER_UPDATE');
    if (lv < 2) return const [];
    if (lv == 2) return const [0, 1];
    return const [0, 1, 2, 3];
  }
}
