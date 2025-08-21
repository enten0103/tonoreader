import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:voidlord/pages/admin/controller.dart';

/// 权限模块（openapi: /permissions/...）——沿用现有实现，封装为 Tab
class PermissionsTab extends GetView<AdminController> {
  const PermissionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.value.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: controller.loadPermissions,
                child: const Text('重试'),
              ),
            ],
          ),
        );
      }

      final list = controller.permissions;
      if (list.isEmpty) {
        return RefreshIndicator(
          onRefresh: controller.loadPermissions,
          child: ListView(
            children: const [
              SizedBox(height: 160),
              Center(child: Text('暂无权限')),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.loadPermissions,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final p = list[index];
            return ListTile(
              leading: const Icon(Icons.verified_user_outlined),
              title: Text(p.permission),
              trailing: _buildLevelChip(p.level),
              subtitle: Text('等级: ${p.level}'),
            );
          },
        ),
      );
    });
  }

  _buildLevelChip(int level) {
    return Chip(
      label: Text('Lv.$level'),
      backgroundColor: _levelColor(level),
      labelStyle: TextStyle(color: _levelColor(level)),
    );
  }

  Color _levelColor(int level) {
    switch (level) {
      case 3:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 1:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
