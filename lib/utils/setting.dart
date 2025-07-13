import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Setting {
  static void apply() {
    setImmersive();
    setImageCache();
    loadConfig();
  }

  static void loadConfig() async {
    loadThemeMode();
    loadColorTheme();
  }

  static void setDefaultBinding() {
    Get.lazyPut(() => SharedPreferences.getInstance());
  }

  static void loadColorTheme() async {
    final prefs = await SharedPreferences.getInstance();
    var a = prefs.getInt("a");
    var r = prefs.getInt("r");
    var g = prefs.getInt("g");
    var b = prefs.getInt("b");
    if (a != null && r != null && g != null && b != null) {
      Get.changeTheme(ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(a, r, g, b))));
    }
  }

  static void loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    var themeMode = prefs.getInt("themeMode");
    if (themeMode != null) {
      if (themeMode == 0) {
        Get.changeThemeMode(ThemeMode.system);
      } else if (themeMode == 1) {
        Get.changeThemeMode(ThemeMode.light);
      } else if (themeMode == 2) {
        Get.changeThemeMode(ThemeMode.dark);
      }
    }
  }

  ///设置主题和沉浸式
  static void setImmersive() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  ///设置图片缓存
  static void setImageCache() {
    PaintingBinding.instance.imageCache.maximumSize = 1000000;
    PaintingBinding.instance.imageCache.maximumSizeBytes = 500 << 20;
  }
}
