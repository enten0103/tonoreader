import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_inline_render.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';

extension TonoTextRender on TonoInlineRender {
  ({InlineSpan span, bool newIndented}) renderText(
    TonoText tonoText,
    bool currentIndented,
  ) {
    final config = Get.find<TonoReaderConfig>();
    final css = tonoText.css.toMap();
    final fontSize = tonoText.css.getFontSize();
    final lineHeight = (parseLineHeight(css['line-height'], fontSize) ?? 1);
    final fontWeight = parseFontWeight(css['font-weight']);
    final indentCount = parseTextIntent(css['text-indent'], fontSize);
    final textColor = parseTextColor(css['color']);
    final fontFamily = paserFontFamily(css['font-family']);
    final shadow = parseTextShadow(css['text-shadow'], fontSize);
    TextStyle ts = TextStyle(
      shadows: shadow == null ? [] : [shadow],
      fontSize: fontSize,
      fontFamily: fontFamily.isNotEmpty ? fontFamily[0] : null,
      textBaseline: TextBaseline.alphabetic,
      fontFamilyFallback: fontFamily,
      height: lineHeight * config.lineSpacing,
      color: textColor,
      fontWeight: fontWeight,
    );

    bool newIndented = currentIndented;
    String text = tonoText.text;

    if (!currentIndented) {
      newIndented = true;
    } else if (tonoText.text == "\n") {
      newIndented = false;
    }

    return (
      span: currentIndented
          ? TextSpan(text: text, style: ts)
          : TextSpan(children: [
              WidgetSpan(
                  child: SizedBox(
                width: currentIndented ? 0 : (fontSize * (indentCount ?? 0)),
              )),
              TextSpan(text: text, style: ts)
            ]),
      newIndented: newIndented,
    );
  }

  double? parseLineHeight(String? cssLineHeight, double em) {
    if (cssLineHeight == null) return null;
    cssLineHeight = cssLineHeight.replaceAll("!important", "");
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

  Color? parseTextColor(String? cssColor) {
    if (cssColor == null) return null;
    return parseColor(cssColor);
  }

  List<String> paserFontFamily(String? cssFontFamily) {
    if (cssFontFamily == null) return [];

    var tp = Get.find<TonoProvider>();
    var raw = cssFontFamily.replaceAll("!important", "").replaceAll(" ", "");
    return raw.split(",").map((e) {
      return tp.fontPrefix + e;
    }).toList();
  }

  int? parseTextIntent(String? cssTextIntent, double em) {
    if (cssTextIntent == null) return null;
    if (cssTextIntent.endsWith("px")) {
      var pxValue = double.parse(cssTextIntent.replaceAll("px", ""));
      return (pxValue / em).round();
    } else if (cssTextIntent.endsWith("em")) {
      var emValue = double.parse(cssTextIntent.replaceAll("em", ""));
      return emValue.round();
    }
    return null;
  }

  TextAlign? parseTextAlign(String? cssTextAlign) {
    if (cssTextAlign == null) return null;
    if (cssTextAlign == "center") {
      return TextAlign.center;
    }
    if (cssTextAlign == "right") {
      return TextAlign.end;
    }
    if (cssTextAlign == "left") {
      return TextAlign.start;
    }
    return null;
  }
}
