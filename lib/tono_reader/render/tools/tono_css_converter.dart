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
}

///
/// 依赖父容器大小
/// 捕获此异常时应提供父容器大小
class NeedParentSizeException extends Error {}

extension ToRawStr on String {
  /// 处理 !important声明&&trim
  String toValue() => replaceAll("!important", "").trim();
}
