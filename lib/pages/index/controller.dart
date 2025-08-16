import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/controller/auth_controller.dart';
import 'package:voidlord/pages/admin/view.dart';
import 'package:voidlord/pages/admin/controller.dart';
import 'package:voidlord/pages/index/home/view.dart';
import 'package:voidlord/pages/index/shelf/view.dart';
import 'package:voidlord/pages/index/user/view.dart';

class IndexController extends GetxController {
  final selectIndex = 0.obs;
  final pages = <Widget>[].obs;

  @override
  void onInit() {
    super.onInit();
    _buildPages();
    // 监听管理员标记变化，动态更新 tabs
    final auth = Get.find<AuthController>();
    ever<bool>(auth.isAdmin, (_) => _buildPages());
  }

  @override
  void onReady() {
    super.onReady();
    // 应用重启后，确保执行一次权限检查（等待存储恢复完毕）
    final auth = Get.find<AuthController>();
    auth.ensureStartupChecked();
  }

  void _buildPages() {
    final auth = Get.find<AuthController>();
    final admin = auth.isAdmin.value;
    final newPages = <Widget>[
      HomePage(),
      ShelfPage(),
      if (admin) _ensureAdminPage(),
      UserPage(),
    ];

    // 保持当前索引在范围内
    final oldIndex = selectIndex.value;
    pages.assignAll(newPages);
    if (oldIndex >= pages.length) {
      selectIndex.value = pages.length - 1;
    }
  }

  Widget _ensureAdminPage() {
    if (!Get.isRegistered<AdminController>()) {
      Get.put(AdminController());
    }
    return const AdminPage();
  }
}
