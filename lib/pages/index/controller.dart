import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/controller/auth_controller.dart';
import 'package:voidlord/pages/admin/view.dart';
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

  void _buildPages() {
    final auth = Get.find<AuthController>();
    final admin = auth.isAdmin.value;
    final newPages = <Widget>[
      HomePage(),
      ShelfPage(),
      if (admin) const AdminPage(),
      UserPage(),
    ];

    // 保持当前索引在范围内
    final oldIndex = selectIndex.value;
    pages.assignAll(newPages);
    if (oldIndex >= pages.length) {
      selectIndex.value = pages.length - 1;
    }
  }
}
