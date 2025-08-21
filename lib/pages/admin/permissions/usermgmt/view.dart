import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/pages/admin/permissions/usermgmt/controller.dart';
import 'package:voidlord/model/dto/user_dto.dart';

class UsersManagePage extends StatelessWidget {
  const UsersManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersManageController>(
      init: UsersManageController(),
      builder: (c) {
        return Column(
          children: [
            _Toolbar(c: c),
            const Divider(height: 1),
            Expanded(
              child: Obx(() {
                if (c.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (c.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(c.errorMessage.value,
                            style: const TextStyle(color: Colors.red)),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: c.load,
                          child: const Text('重试'),
                        ),
                      ],
                    ),
                  );
                }

                final list = c.filtered;
                if (list.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: c.load,
                    child: ListView(
                      children: const [
                        SizedBox(height: 160),
                        Center(child: Text('暂无用户')),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: c.load,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final u = list[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(u.username.isNotEmpty
                              ? u.username[0].toUpperCase()
                              : '?'),
                        ),
                        title: Text(u.username),
                        subtitle: Text(u.email ?? '-'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (u.createdAt != null)
                              Text('创建: ${_fmt(u.createdAt!)}'),
                            if (u.updatedAt != null)
                              Text('更新: ${_fmt(u.updatedAt!)}'),
                          ],
                        ),
                        onTap: () {
                          // 先同步打开弹窗，避免 async gap 后再使用 BuildContext
                          _showPermissionSheet(context, c, user: u);
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }

  String _fmt(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}

void _showPermissionSheet(BuildContext context, UsersManageController c,
    {required User user}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      final theme = Theme.of(ctx);
      // 在弹窗生命周期内加载指定用户权限
      c.openPermissionSheet(user);
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) {
          return Obx(() {
            final u = c.targetUser.value;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        u == null ? '权限管理' : '权限管理 - ${u.username}',
                        style: theme.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Obx(() {
                        final hasPending = c.pending.isNotEmpty;
                        return FilledButton.icon(
                          onPressed: hasPending && !c.saving.value
                              ? c.submitPending
                              : null,
                          icon: const Icon(Icons.save_outlined),
                          label: Text(hasPending ? '提交变更' : '已最新'),
                        );
                      }),
                      const SizedBox(width: 8),
                      c.saving.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    if (c.isPermLoading.value) {
                      return const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (c.permError.value.isNotEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                c.permError.value,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: c.loadTargetPermissions,
                                child: const Text('重试'),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // 权限清单（按名称排序，若为空则展示空态）
                    final items = c.targetPermissions.toList()
                      ..sort((a, b) => a.permission.compareTo(b.permission));
                    final showHint = items.isEmpty;
                    // 依赖 pending 让列表随更改刷新
                    final _ = c.pending.length;

                    return Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount:
                            _allPermissionKeys.length + (showHint ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (showHint && index == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                '该用户暂无权限记录，可在下方为其授予权限',
                                style: theme.textTheme.bodySmall,
                              ),
                            );
                          }
                          final keyIndex = showHint ? index - 1 : index;
                          final key = _allPermissionKeys[keyIndex];
                          final current = c.getPermissionLevel(key);
                          return _PermissionTile(
                            name: key,
                            level: current,
                            allowedLevels: c.allowedLevelsFor(key),
                            onChanged: (lv) => c.setPendingLevel(
                              permission: key,
                              level: lv,
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            );
          });
        },
      );
    },
  );
}

// 所有后端支持的权限键（与 openapi.json 对齐）
const List<String> _allPermissionKeys = [
  'USER_READ',
  'USER_CREATE',
  'USER_UPDATE',
  'USER_DELETE',
  'BOOK_READ',
  'BOOK_CREATE',
  'BOOK_UPDATE',
  'BOOK_DELETE',
  'RECOMMENDATION_MANAGE',
];

class _PermissionTile extends StatelessWidget {
  final String name;
  final int level; // 0..3
  final List<int> allowedLevels;
  final ValueChanged<int> onChanged;

  const _PermissionTile({
    required this.name,
    required this.level,
    required this.allowedLevels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final captions = const [
      '无权限',
      '基础使用',
      '授予/撤销其授予的 level 1',
      '完全管理',
    ];
    final lv = level.clamp(0, 3);
    final disabled = allowedLevels.isEmpty;
    return ListTile(
      title: Text(name),
      subtitle: Text(captions[lv]),
      trailing: IgnorePointer(
        ignoring: disabled,
        child: Opacity(
          opacity: disabled ? 0.5 : 1,
          child: DropdownButton<int>(
            value: lv,
            onChanged: (v) {
              if (v != null && allowedLevels.contains(v)) onChanged(v);
            },
            items: [
              for (final i in const [0, 1, 2, 3])
                DropdownMenuItem(
                  value: i,
                  enabled: allowedLevels.contains(i),
                  child: Text('$i: ${captions[i]}'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Toolbar extends StatelessWidget {
  final UsersManageController c;
  const _Toolbar({required this.c});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // 搜索框
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: '搜索用户名或邮箱',
                border: const OutlineInputBorder(),
                isDense: true,
                suffixIcon: Obx(() => c.keyword.value.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        tooltip: '清除',
                        icon: const Icon(Icons.clear),
                        onPressed: () => c.keyword.value = '',
                      )),
              ),
              onChanged: (v) => c.keyword.value = v,
            ),
          ),
          const SizedBox(width: 12),
          // 筛选按钮
          Obx(() => FilterChip(
                selected: c.showWithEmailOnly.value,
                label: const Text('仅显示有邮箱'),
                onSelected: (v) => c.showWithEmailOnly.value = v,
              )),
          const SizedBox(width: 12),
          Tooltip(
            message: '刷新',
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: c.load,
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: () {
              // 预留：创建用户
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('创建用户功能尚未实现')),
              );
            },
            icon: const Icon(Icons.person_add_alt_1),
            label: const Text('新建'),
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
