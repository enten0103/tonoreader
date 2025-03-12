import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/render/tono_render.dart';

extension TonoCssRender on TonoRender {
  double fontSizeParse(String? value, double em) {
    if (value == null) return em;
    try {
      var fontSize = em;
      String numberPart = value.replaceAll(RegExp(r'[^\d.]'), ''); // 提取 "1.1"
      String unitPart = value.replaceAll(RegExp(r'[\d.]'), ''); // 提取 "em"
      if (unitPart == 'em') {
        fontSize = double.parse(numberPart) * em;
        return fontSize;
      }
      if (unitPart == 'px') {
        fontSize = double.parse(numberPart);
        return fontSize;
      }
      return em;
    } catch (_) {
      return em;
    }
  }

  double? parseHeight(String? cssHeight, double em) {
    if (cssHeight == null) return null;
    if (cssHeight.contains('em')) {
      double emValue = double.parse(cssHeight.replaceAll('em', '')) * em;
      return emValue;
    } else if (cssHeight.contains('px')) {
      double pxValue = double.parse(cssHeight.replaceAll('px', ''));
      return pxValue;
    } else if (cssHeight.contains('%')) {
      double percentage = double.parse(cssHeight.replaceAll('%', ''));
      return Get.mediaQuery.size.width * percentage / 100.0;
    } else if (cssHeight.contains('vh')) {
      double vhValue = double.parse(cssHeight.replaceAll('vh', ''));
      return Get.mediaQuery.size.height * vhValue / 100;
    } else {
      return double.parse(cssHeight);
    }
  }

  EdgeInsets? parseMarginLetf(String? cssMarginLeft, double width, double em) {
    if (cssMarginLeft == null) return null;
    if (cssMarginLeft == "auto") {
      return null;
    }
    return EdgeInsets.only(left: parseUnit(cssMarginLeft, width, em));
  }

  EdgeInsets? parseMarginRight(
      String? cssMarginRight, double width, double em) {
    if (cssMarginRight == null) return null;
    if (cssMarginRight == "auto") {
      return null;
    }
    return EdgeInsets.only(right: parseUnit(cssMarginRight, width, em));
  }

  EdgeInsets? parseMarginTop(String? cssMarginTop, double width, double em) {
    if (cssMarginTop == null) return null;
    if (cssMarginTop == "auto") {
      return null;
    }
    return EdgeInsets.only(top: parseUnit(cssMarginTop, width, em));
  }

  EdgeInsets? parseMarginBottom(
      String? cssMarginBottom, double width, double em) {
    if (cssMarginBottom == null) return null;
    if (cssMarginBottom == "auto") {
      return null;
    }

    return EdgeInsets.only(bottom: parseUnit(cssMarginBottom, width, em));
  }

  EdgeInsets? parsePaddingAll(Map<String, String> css, double em) {
    List<EdgeInsets> margins = [];
    var width = Get.mediaQuery.size.width;
    var margin = parseMargin(css['padding'], parentWidth: width, em);
    if (margin != null) margins.add(margin);
    var marginLeft = parseMarginLetf(css['padding-left'], width, em);
    if (marginLeft != null) margins.add(marginLeft);
    var marginRight = parseMarginRight(css['padding-right'], width, em);
    if (marginRight != null) margins.add(marginRight);
    var marginTop = parseMarginTop(css['padding-top'], width, em);
    if (marginTop != null) margins.add(marginTop);
    var marginBottom = parseMarginBottom(css['padding-bottom'], width, em);
    if (marginBottom != null) margins.add(marginBottom);
    if (margins.isEmpty) return null;
    double top = 0.0;
    double right = 0.0;
    double bottom = 0.0;
    double left = 0.0;
    for (EdgeInsets margin in margins) {
      top += margin.top;
      right += margin.right;
      bottom += margin.bottom;
      left += margin.left;
    }
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  EdgeInsets? parseMarginAll(Map<String, String> css, double em) {
    List<EdgeInsets> margins = [];
    var width = Get.mediaQuery.size.width;
    var margin = parseMargin(css['margin'], em, parentWidth: width);
    if (margin != null) {
      return margin;
    }
    var marginLeft = parseMarginLetf(css['margin-left'], width, em);
    if (marginLeft != null) margins.add(marginLeft);
    var marginRight = parseMarginRight(css['margin-right'], width, em);
    if (marginRight != null) margins.add(marginRight);
    var marginTop = parseMarginTop(css['margin-top'], width, em);
    if (marginTop != null) margins.add(marginTop);
    var marginBottom = parseMarginBottom(css['margin-bottom'], width, em);
    if (marginBottom != null) margins.add(marginBottom);
    if (margins.isEmpty) return null;
    double top = 0.0;
    double right = 0.0;
    double bottom = 0.0;
    double left = 0.0;
    for (EdgeInsets margin in margins) {
      top += margin.top;
      right += margin.right;
      bottom += margin.bottom;
      left += margin.left;
    }

    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  double parseUnit(String cssUnit, double width, double em) {
    if (cssUnit.contains('em')) {
      double emValue = double.parse(cssUnit.replaceAll('em', '')) * em;
      return emValue;
    } else if (cssUnit.contains('px')) {
      double pxValue = double.parse(cssUnit.replaceAll('px', ''));
      return pxValue;
    } else if (cssUnit.contains('%')) {
      double percentage = double.parse(cssUnit.replaceAll('%', ''));
      return width * percentage / 100.0;
    } else if (cssUnit.contains('vh')) {
      double vhValue = double.parse(cssUnit.replaceAll('vh', ''));
      return Get.mediaQuery.size.height * vhValue / 100;
    } else {
      return double.parse(cssUnit);
    }
  }

  Color? parseColor(String hexColor) {
    String hex = hexColor.replaceAll('#', '').toUpperCase();

    if (hex.length == 3) {
      hex = hex.split('').map((c) => c + c).join(); // F53 → FF5533
      hex = 'FF$hex'; // 添加透明度
    } else if (hex.length == 6) {
      hex = 'FF$hex'; // 6 位补全透明度
    }

    if (hex.length != 8) {
      return null;
    }

    return Color(int.parse(hex, radix: 16));
  }

  double? parseBorderWidth(String? cssBorderWidth, double em) {
    if (cssBorderWidth == null) return null;
    return parseUnit(cssBorderWidth, Get.mediaQuery.size.width, em);
  }

  Color? parseBorderColor(String? cssBorderColor) {
    if (cssBorderColor == null) return null;
    return parseColor(cssBorderColor);
  }

  double? parseLineHeight(String? cssLineHeight, double em) {
    if (cssLineHeight == null) return null;
    if (cssLineHeight.contains('em')) {
      double emValue = double.parse(cssLineHeight.replaceAll('em', '')) * em;
      return emValue / em;
    } else if (cssLineHeight.contains('px')) {
      double pxValue = double.parse(cssLineHeight.replaceAll('px', ''));
      return pxValue / em;
    } else if (cssLineHeight.contains('%')) {
      double percentage = double.parse(cssLineHeight.replaceAll('%', ''));
      return percentage / 100.0;
    } else {
      return double.parse(cssLineHeight);
    }
  }

  FontWeight? parseFontWeight(String? cssFontWeight) {
    if (cssFontWeight == null) return null;
    switch (cssFontWeight.toLowerCase()) {
      case '100':
        return FontWeight.w100;
      case '200':
        return FontWeight.w200;
      case '300':
        return FontWeight.w300;
      case '400':
      case 'normal':
        return FontWeight.w400;
      case '500':
        return FontWeight.w500;
      case '600':
        return FontWeight.w600;
      case '700':
      case 'bold':
        return FontWeight.w700;
      case '800':
        return FontWeight.w800;
      case '900':
        return FontWeight.w900;
      default:
        return FontWeight.w400; // 默认值，处理未知情况
    }
  }

  EdgeInsets? parseMargin(String? cssMargin, double em,
      {required double parentWidth, // 用于 % 单位
      double lineSpacing = 1}) {
    if (cssMargin == null) return null;
    // 分割值并移除单位
    List<String> values = cssMargin.trim().split(' ');
    double top, right, bottom, left;

    // 处理单位并转换为数值
    double parseValue(String value, double em) {
      if (value.endsWith('auto')) {
        return 1;
      }
      if (value.endsWith('px')) {
        return double.parse(value.replaceAll('px', '')) * lineSpacing;
      } else if (value.endsWith('em')) {
        return double.parse(value.replaceAll('em', '')) * em * lineSpacing;
      } else if (value.endsWith('%')) {
        return double.parse(value.replaceAll('%', '')) *
            parentWidth /
            100.0 *
            lineSpacing;
      } else {
        return double.parse(value) * lineSpacing; // 无单位默认按 px 处理
      }
    }

    // 根据值的数量处理
    if (values.length == 1) {
      // margin: 10px
      top = right = bottom = left = parseValue(values[0], em);
    } else if (values.length == 2) {
      // margin: 10px 20px
      top = bottom = parseValue(values[0], em);

      left = right = parseValue(values[1], em);
    } else if (values.length == 3) {
      // margin: 10px 20px 30px
      top = parseValue(values[0], em);
      left = right = parseValue(values[1], em);
      bottom = parseValue(values[2], em);
    } else if (values.length == 4) {
      // margin: 10px 20px 30px 40px
      top = parseValue(values[0], em);
      right = parseValue(values[1], em);
      bottom = parseValue(values[2], em);
      left = parseValue(values[3], em);
    } else {
      return EdgeInsets.zero; // 默认值
    }
    if (bottom < 0) {
      bottom = 0;
    }
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  int? parseTextIntent(String? cssTextIntent, double em) {
    if (cssTextIntent == null) return null;
    if (cssTextIntent.endsWith("px")) {
      var pxValue = double.parse(cssTextIntent.replaceAll("px", ""));
      return (pxValue / em * 4).round();
    } else if (cssTextIntent.endsWith("em")) {
      var emValue = double.parse(cssTextIntent.replaceAll("em", ""));
      return (emValue * 4).round();
    }
    return null;
  }

  Border? parseBorderLeft(String? cssBorder, double em) {
    if (cssBorder == null) return null;
    var borderSplited = cssBorder.split(" ");
    Border singleBorder(List<String> values) {
      return Border(left: BorderSide(width: 2));
    }

    Border twoBorder(List<String> values) {
      var unit = parseUnit(values[0], Get.mediaQuery.size.width, em);
      return Border(left: BorderSide(width: unit));
    }

    Border threeBorder(List<String> values) {
      var unit = parseUnit(values[0], Get.mediaQuery.size.width, em);
      var color = parseColor(values[2]);
      return Border(
          left: BorderSide(width: unit, color: color ?? Colors.black));
    }

    if (borderSplited.length == 1) {
      return singleBorder(borderSplited);
    }
    if (borderSplited.length == 2) {
      return twoBorder(borderSplited);
    }
    if (borderSplited.length == 3) {
      return threeBorder(borderSplited);
    }
    return null;
  }

  Border? parseBorder(String? cssBorder, double em) {
    if (cssBorder == null) return null;
    var borderSplited = cssBorder.split(" ");
    Border singleBorder(List<String> values) {
      return Border.all(width: 2);
    }

    Border twoBorder(List<String> values) {
      var unit = parseUnit(values[0], Get.mediaQuery.size.width, em);
      return Border.all(width: unit);
    }

    Border threeBorder(List<String> values) {
      var unit = parseUnit(values[0], Get.mediaQuery.size.width, em);
      var color = parseColor(values[2]);
      return Border.all(width: unit, color: color ?? Colors.black);
    }

    if (borderSplited.length == 1) {
      return singleBorder(borderSplited);
    }
    if (borderSplited.length == 2) {
      return twoBorder(borderSplited);
    }
    if (borderSplited.length == 3) {
      return threeBorder(borderSplited);
    }
    return null;
  }

  double? parseBorderRadius(String? cssBorderRider, double em) {
    if (cssBorderRider == null) return null;
    return parseUnit(cssBorderRider, Get.mediaQuery.size.width, em);
  }

  Color? parseBackgroundColor(String? cssBackgroundColor) {
    if (cssBackgroundColor == null) return null;
    return parseColor(cssBackgroundColor);
  }

  Color? parseTextColor(String? cssColor) {
    if (cssColor == null) return null;
    return parseColor(cssColor);
  }

  Shadow? parseTextShadow(String? textShadow, double em) {
    if (textShadow == null) return null;
    var shadowSplit = textShadow.split(" ");
    var xOffset = parseUnit(shadowSplit[0], Get.mediaQuery.size.width, em);
    var yOffset = parseUnit(shadowSplit[1], Get.mediaQuery.size.width, em);
    var blurRadius = parseUnit(shadowSplit[2], Get.mediaQuery.size.width, em);

    var color = parseColor(shadowSplit[3]);
    return Shadow(
        color: color ?? Colors.black,
        offset: Offset(xOffset, yOffset),
        blurRadius: blurRadius);
  }

  double? parseWidth(String? cssWidth, double em) {
    if (cssWidth == null) return null;
    return parseUnit(cssWidth, Get.mediaQuery.size.width, em);
  }

  double? parseFontSize(String? cssFontSize, double em) {
    if (cssFontSize == null) return null;
    return parseUnit(cssFontSize, Get.width, em);
  }

  List<String> paserFontFamily(String? cssFontFamily) {
    if (cssFontFamily == null) return [];
    var raw = cssFontFamily.replaceAll("!important", "").replaceAll(" ", "");
    return raw.split(",");
  }
}
