import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/pages/admin/controller.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AdminController>(builder: (c) {
      final destinations = c.destinations;

      final rail = NavigationRail(
        selectedIndex: c.selectedIndex.value,
        onDestinationSelected: c.onDestinationSelected,
        labelType: NavigationRailLabelType.all,
        destinations: [
          for (final d in destinations)
            NavigationRailDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.icon),
              label: Text(d.label),
            ),
        ],
      );

      final body = c.currentBody;
      final isNarrow = MediaQuery.of(context).size.width < 640;

      return Scaffold(
        key: c.scaffoldKey,
        appBar: AppBar(
          title: const Text('管理'),
          leading: isNarrow
              ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => c.scaffoldKey.currentState?.openDrawer(),
                )
              : null,
        ),
        drawer: isNarrow
            ? Drawer(
                child: SafeArea(
                  child: ListView(
                    children: [
                      for (int i = 0; i < destinations.length; i++)
                        ListTile(
                          leading: Icon(destinations[i].icon),
                          title: Text(destinations[i].label),
                          selected: c.selectedIndex.value == i,
                          onTap: () {
                            c.onDestinationSelected(i);
                            Navigator.of(context).pop();
                          },
                        ),
                    ],
                  ),
                ),
              )
            : null,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final useRail = constraints.maxWidth >= 640;
            if (useRail) {
              return Row(
                children: [
                  rail,
                  const VerticalDivider(width: 1),
                  Expanded(child: body),
                ],
              );
            }
            // 窄屏仅展示内容，导航通过 Drawer 切换
            return Row(
              children: [
                Expanded(child: body),
              ],
            );
          },
        ),
      );
    });
  }
}

// 目的地模型迁移至 AdminController
