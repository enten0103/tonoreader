import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ruby_text/ruby_text.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_state.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_css_margin_widget.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_css_size_padding_widget.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';

class TonoRubyWidget extends StatelessWidget {
  const TonoRubyWidget({super.key, required this.tonoRuby});
  final TonoRuby tonoRuby;
  @override
  Widget build(BuildContext context) {
    var config = Get.find<TonoReaderConfig>();
    Get.find<TonoContainerState>().container = tonoRuby;
    var css = tonoRuby.css.toMap();
    var fontSize = tonoRuby.css.getFontSize();
    var fontFamily = paserFontFamily(css['font-family']);
    List<RubyTextData> rtds = [];
    var indent = "";
    var indentCount = parseTextIntent(css['text-indent'], fontSize);
    if (indentCount != null) {
      for (var i = 0; i < indentCount; i++) {
        indent += " ";
      }
    }
    rtds.add(RubyTextData(indent));
    for (var text in tonoRuby.texts) {
      if (text.ruby == null) {
        for (var i = 0; i < text.text.length; i++) {
          rtds.add(RubyTextData(text.text[i]));
        }
      } else {
        rtds.add(RubyTextData(text.text, ruby: text.ruby));
      }
    }

    var lineHeight = parseLineHeight(css['line-height'], fontSize) ?? 1;
    var fontWeight = parseFontWeight(css['font-weight']);

    return TonoCssMarginWidget(
        child: TonoCssSizePaddingWidget(
            child: RubyText(
      rtds,
      style: TextStyle(
        fontSize: fontSize,
        height: lineHeight * config.lineSpacing,
        fontFamilyFallback: fontFamily,
        fontWeight: fontWeight,
      ),
      textAlign: css["text-align"] == 'center' ? TextAlign.center : null,
      rubyStyle: TextStyle(height: config.rubySize),
    )));
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
      return (pxValue / em * 4).round();
    } else if (cssTextIntent.endsWith("em")) {
      var emValue = double.parse(cssTextIntent.replaceAll("em", ""));
      return (emValue * 4).round();
    }
    return null;
  }
}
