import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/bindings/default_binding.dart';
import 'package:voidlord/routes/void_routers.dart';
import 'package:voidlord/utils/setting.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Setting.apply();
    return GetMaterialApp(
        title: 'voidlord',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          textTheme: TextTheme(),
          useMaterial3: true,
        ),
        getPages: VoidRouters.getPages,
        initialBinding: DefaultBing(),
        initialRoute: VoidRouters.indexPage);
  }
}
