import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/api/permission_api.dart';
import 'package:voidlord/model/dto/auth_dto.dart';

class AuthController extends GetxController {
  final RxString _token = ''.obs;
  final Rx<LoginUser?> user = Rx<LoginUser?>(null);
  final RxBool isAdmin = false.obs; // 是否具备任一权限 level > 2

  set token(String token) {
    _token.value = token;
    try {
      if (Get.isRegistered<SharedPreferences>()) {
        SharedPreferences preferences = Get.find();
        preferences.setString('auth_token', token);
      }
    } catch (_) {}
  }

  String get token {
    if (_token.value.isNotEmpty) return _token.value;
    try {
      if (Get.isRegistered<SharedPreferences>()) {
        SharedPreferences preferences = Get.find();
        return preferences.getString('auth_token') ?? '';
      }
    } catch (_) {}
    return '';
  }

  @override
  void onInit() {
    super.onInit();
    // 尝试从本地恢复 token（应用启动检查）
    final t = token; // 触发从 SharedPreferences 读取
    _restoreUser();
    if (t.isNotEmpty && user.value != null) {
      // 应用启动时检查权限
      checkPermissions();
    }
  }

  /// 登录完成后设置用户信息并检查权限
  Future<void> handleLogin(LoginResponseData data) async {
    token = data.accessToken;
    user.value = data.user;
    // 持久化用户信息便于下次启动恢复
    try {
      if (Get.isRegistered<SharedPreferences>()) {
        final prefs = Get.find<SharedPreferences>();
        await prefs.setInt('user_id', data.user.id);
        await prefs.setString('user_username', data.user.username);
        if (data.user.email != null) {
          await prefs.setString('user_email', data.user.email!);
        } else {
          await prefs.remove('user_email');
        }
      }
    } catch (_) {}
    await checkPermissions();
  }

  /// 检查当前用户是否拥有任一权限 level > 2
  Future<void> checkPermissions() async {
    final u = user.value;
    if (token.isEmpty || u == null) {
      isAdmin.value = false;
      return;
    }
    try {
      final api = Get.find<Api>();
      final list = await api.getUserPermissions(u.id);
      isAdmin.value = list.any((p) => p.level > 2);
    } catch (_) {
      // 网络失败等情况，保守为 false，不中断流程
      isAdmin.value = false;
    }
  }

  void _restoreUser() {
    try {
      if (!Get.isRegistered<SharedPreferences>()) return;
      final prefs = Get.find<SharedPreferences>();
      final id = prefs.getInt('user_id');
      final username = prefs.getString('user_username');
      if (id != null && username != null) {
        final email = prefs.getString('user_email');
        user.value = LoginUser(id: id, username: username, email: email);
      }
    } catch (_) {}
  }
}
