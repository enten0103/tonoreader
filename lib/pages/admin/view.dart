import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/pages/admin/controller.dart';

class AdminPage extends GetView<AdminController> {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('管理')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
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
                trailing: _LevelChip(level: p.level),
                subtitle: Text('等级: ${p.level}'),
              );
            },
          ),
        );
      }),
    );
  }
}

class _LevelChip extends StatelessWidget {
  final int level;
  const _LevelChip({required this.level});

  Color _color(int l, BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (l) {
      case 3:
        return scheme.primary;
      case 2:
        return scheme.tertiary;
      case 1:
        return scheme.secondary;
      default:
        return scheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('Lv.$level'),
      backgroundColor: _color(level, context).withOpacity(0.15),
      labelStyle: TextStyle(color: _color(level, context)),
    );
  }
}
