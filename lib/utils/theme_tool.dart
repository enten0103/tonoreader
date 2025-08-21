import 'package:flutter/material.dart';

extension ThemeTool on ThemeData {
  /// 应用全局字体与更粗的字重，默认使用 PingFang 与 w500
  ThemeData withAppFont(
      {String fontFamily = 'PingFang', FontWeight weight = FontWeight.w500}) {
    final base = this;
    final applied = base.textTheme.apply(fontFamily: fontFamily);
    final bolder = _bolderTextTheme(applied, weight);
    return base.copyWith(textTheme: bolder);
  }
}

TextTheme _bolderTextTheme(TextTheme t, FontWeight w) {
  return t.copyWith(
    displayLarge: t.displayLarge?.copyWith(fontWeight: w),
    displayMedium: t.displayMedium?.copyWith(fontWeight: w),
    displaySmall: t.displaySmall?.copyWith(fontWeight: w),
    headlineLarge: t.headlineLarge?.copyWith(fontWeight: w),
    headlineMedium: t.headlineMedium?.copyWith(fontWeight: w),
    headlineSmall: t.headlineSmall?.copyWith(fontWeight: w),
    titleLarge: t.titleLarge?.copyWith(fontWeight: w),
    titleMedium: t.titleMedium?.copyWith(fontWeight: w),
    titleSmall: t.titleSmall?.copyWith(fontWeight: w),
    bodyLarge: t.bodyLarge?.copyWith(fontWeight: w),
    bodyMedium: t.bodyMedium?.copyWith(fontWeight: w),
    bodySmall: t.bodySmall?.copyWith(fontWeight: w),
    labelLarge: t.labelLarge?.copyWith(fontWeight: w),
    labelMedium: t.labelMedium?.copyWith(fontWeight: w),
    labelSmall: t.labelSmall?.copyWith(fontWeight: w),
  );
}
