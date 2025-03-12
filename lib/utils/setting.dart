import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Setting {
  static void apply() {
    setImmersive();
    setImageCache();
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
    PaintingBinding.instance.imageCache.maximumSizeBytes = 300 << 20;
  }
}
