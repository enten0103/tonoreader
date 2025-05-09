import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/bindings/default_binding.dart';
import 'package:voidlord/routes/void_routers.dart';
import 'package:voidlord/utils/setting.dart';

void main() => runApp(const Voidlord());

class Voidlord extends StatelessWidget {
  const Voidlord({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
      title: 'voidlord',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      getPages: VoidRouters.getPages,
      onInit: Setting.apply,
      initialBinding: DefaultBing(),
      initialRoute: VoidRouters.indexPage);
}
