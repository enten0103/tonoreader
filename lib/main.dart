import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/bindings/default_binding.dart';
import 'package:voidlord/routes/void_routers.dart';
import 'package:voidlord/utils/setting.dart';
import 'package:voidlord/utils/theme_tool.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DefaultBinding().dependencies();
  runApp(const Voidlord());
}

class Voidlord extends StatelessWidget {
  const Voidlord({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'voidlord',
        debugShowCheckedModeBanner: false,
        // Dark theme with PingFang and bolder text
        darkTheme: ThemeData.dark(useMaterial3: true).withAppFont(),
        // Light theme with PingFang and bolder text
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ).withAppFont(),
        getPages: VoidRouters.getPages,
        onInit: Setting.apply,
        initialRoute: VoidRouters.indexPage,
      );
}
