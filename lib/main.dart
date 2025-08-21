import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/bindings/default_binding.dart';
import 'package:voidlord/routes/void_routers.dart';
import 'package:voidlord/utils/setting.dart';

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
        darkTheme: () {
          final base = ThemeData.dark(useMaterial3: true);
          return base.copyWith(
            textTheme: _applyFontAndWeight(base.textTheme),
          );
        }(),
        // Light theme with PingFang and bolder text
        theme: () {
          final base = ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          );
          return base.copyWith(
            textTheme: _applyFontAndWeight(base.textTheme),
          );
        }(),
        getPages: VoidRouters.getPages,
        onInit: Setting.apply,
        initialRoute: VoidRouters.indexPage,
      );
}

TextTheme _applyFontAndWeight(TextTheme t) {
  // 先应用字体，再整体加粗一点
  final base = t.apply(fontFamily: 'PingFang');
  const w = FontWeight.w500; // 稍微加粗
  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(fontWeight: w),
    displayMedium: base.displayMedium?.copyWith(fontWeight: w),
    displaySmall: base.displaySmall?.copyWith(fontWeight: w),
    headlineLarge: base.headlineLarge?.copyWith(fontWeight: w),
    headlineMedium: base.headlineMedium?.copyWith(fontWeight: w),
    headlineSmall: base.headlineSmall?.copyWith(fontWeight: w),
    titleLarge: base.titleLarge?.copyWith(fontWeight: w),
    titleMedium: base.titleMedium?.copyWith(fontWeight: w),
    titleSmall: base.titleSmall?.copyWith(fontWeight: w),
    bodyLarge: base.bodyLarge?.copyWith(fontWeight: w),
    bodyMedium: base.bodyMedium?.copyWith(fontWeight: w),
    bodySmall: base.bodySmall?.copyWith(fontWeight: w),
    labelLarge: base.labelLarge?.copyWith(fontWeight: w),
    labelMedium: base.labelMedium?.copyWith(fontWeight: w),
    labelSmall: base.labelSmall?.copyWith(fontWeight: w),
  );
}
