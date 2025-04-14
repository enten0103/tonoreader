import 'dart:ui';

import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/model/style/tono_style.dart';

///
/// 转换[TonoStyle]到flutter组件
///
extension TonoCssConverter on List<TonoStyle> {
  ///
  /// 转换实现
  ///
  FlutterStyleFromCss convert() {
    return FlutterStyleFromCss(css: toMap());
  }

  ///转换 [List<TonoStyle>] 为 [Map<String,String>]
  Map<String, String> toMap() {
    Map<String, String> result = {};
    forEach((e) {
      result[e.property] = e.value;
    });
    return result;
  }
}

///
/// css到flutter组件映像
///
class FlutterStyleFromCss {
  /// 字体大小
  late double em;

  /// 配置
  late TonoReaderConfig config;

  /// css映射实体
  final Map<String, String> css;

  /// 父容器大小
  Size? parentSize;

  FlutterStyleFromCss({
    required this.css,
  }) {
    config = Get.find<TonoReaderConfig>();
    var width = Get.mediaQuery.size.width;
    em = parseUnit(css['font-size']!, width, config.fontSize);
  }

  ///
  /// 初始化父容器大小
  void initParentSize(Size parentSize) {
    this.parentSize = parentSize;
  }

  ///
  /// [cssUnit] 原css文本 [parent] 父容器尺寸 [em] 当前字体大小
  ///
  /// css 单位转 flutter px
  ///
  /// [em] [px] [%] [vh] [vw] -> px
  ///
  /// parent 应根据方向自取
  /// 默认应为width,少数情况下为height
  ///
  double parseUnit(
    String cssUnit,
    double? parent,
    double em,
  ) {
    /// em
    if (cssUnit.contains('em')) {
      double emValue = double.parse(cssUnit.replaceAll('em', '')) * em;
      return emValue;

      /// px
    } else if (cssUnit.contains('px')) {
      double pxValue = double.parse(cssUnit.replaceAll('px', ''));
      return pxValue;

      /// %
    } else if (cssUnit.contains('%')) {
      if (parent == null) throw NeedParentSizeException();
      double percentage = double.parse(cssUnit.replaceAll('%', ''));
      return parent * percentage / 100.0;

      /// vh
    } else if (cssUnit.contains('vh')) {
      double vhValue = double.parse(cssUnit.replaceAll('vh', ''));
      return Get.mediaQuery.size.height * vhValue / 100;

      /// vw
    } else if (cssUnit.contains("vw")) {
      double vwValue = double.parse(cssUnit.replaceAll('vw', ''));
      return Get.mediaQuery.size.height * vwValue / 100;
    } else {
      /// px
      return double.parse(cssUnit);
    }
  }

  Color? parseColor(String colorStr) {
    final normalized = colorStr
        .replaceAll(RegExp(r'[#!important]', caseSensitive: false), '')
        .trim()
        .toLowerCase();

    // 处理颜色名称
    if (_colorNameToHex.containsKey(normalized)) {
      return _parseHex('FF${_colorNameToHex[normalized]}');
    }

    // 处理RGB/RGBA
    if (normalized.startsWith('rgb')) {
      return _parseRgb(normalized);
    }

    // 处理十六进制
    return _parseHex(normalized);
  }

  Color? _parseHex(String hex) {
    hex = hex.toUpperCase();

    if (hex.length == 3) {
      hex = hex.split('').map((c) => c + c).join();
      hex = 'FF$hex';
    } else if (hex.length == 6) {
      hex = 'FF$hex';
    }

    if (hex.length != 8) return null;

    try {
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return null;
    }
  }

  Color? _parseRgb(String rgbStr) {
    final params =
        rgbStr.replaceAll(RegExp(r'^rgba?\(|\)$', caseSensitive: false), '');
    final parts = params.split(',').map((s) => s.trim()).toList();

    if (parts.length != 3 && parts.length != 4) return null;

    final r = _parseColorValue(parts[0]);
    final g = _parseColorValue(parts[1]);
    final b = _parseColorValue(parts[2]);
    if (r == null || g == null || b == null) return null;

    double a = 1.0;
    if (parts.length == 4) {
      final parsedA = _parseAlphaValue(parts[3]);
      if (parsedA == null) return null;
      a = parsedA;
    }

    final alphaHex = (a * 255).round().toRadixString(16).padLeft(2, '0');
    final hex = alphaHex +
        r.toRadixString(16).padLeft(2, '0') +
        g.toRadixString(16).padLeft(2, '0') +
        b.toRadixString(16).padLeft(2, '0');

    return _parseHex(hex);
  }

  int? _parseColorValue(String part) {
    try {
      if (part.endsWith('%')) {
        final percent = double.parse(part.substring(0, part.length - 1));
        return (percent / 100 * 255).round().clamp(0, 255);
      }
      return int.parse(part).clamp(0, 255);
    } catch (e) {
      return null;
    }
  }

  double? _parseAlphaValue(String part) {
    try {
      if (part.endsWith('%')) {
        return double.parse(part.substring(0, part.length - 1)) / 100;
      }
      return double.parse(part).clamp(0.0, 1.0);
    } catch (e) {
      return null;
    }
  }

  static const _colorNameToHex = {
    'black': '000000',
    'white': 'ffffff',
    'red': 'ff0000',
    'lime': '00ff00',
    'blue': '0000ff',
    'yellow': 'ffff00',
    'cyan': '00ffff',
    'magenta': 'ff00ff',
    'silver': 'c0c0c0',
    'gray': '808080',
    'maroon': '800000',
    'olive': '808000',
    'green': '008000',
    'purple': '800080',
    'teal': '008080',
    'navy': '000080',
    'orange': 'ffa500',
  };
}

///
/// 依赖父容器大小
/// 捕获此异常时应提供父容器大小
class NeedParentSizeException extends Error {}

extension ToRawStr on String {
  /// 处理 !important声明&&trim
  String toValue() => replaceAll("!important", "").trim();
}
