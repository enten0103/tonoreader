import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_margin.dart';
import 'package:voidlord/tono_reader/render/tono_css_render.dart';
import 'package:voidlord/tono_reader/render/tono_render.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';

extension TextRender on TonoRender {
  Widget rendeText(TonoText tonoText, double em) {
    var config = Get.find<TonoReaderConfig>();
    var css = tonoText.css.toMap();
    var fontSize = fontSizeParse(css['font-size'], em);
    var lineHeight = (parseLineHeight(css['line-height'], fontSize) ?? 1);
    var fontWeight = parseFontWeight(css['font-weight']);
    var height = parseHeight(css['height'], fontSize);
    var margin = parseMarginAll(css, fontSize);
    var borderWidth = parseBorderWidth(css['border-width'], fontSize);
    var borderColor = parseBorderColor(css['border-color']);
    var padding = parsePaddingAll(css, fontSize);
    var indent = "";
    var indentCount = parseTextIntent(css['text-indent'], fontSize);
    var textColor = parseTextColor(css['color']);
    if (indentCount != null) {
      for (var i = 0; i < indentCount; i++) {
        indent += " ";
      }
    }
    var fontFamily = paserFontFamily(css['font-family']);
    var shadow = parseTextShadow(css['text-shadow'], fontSize);
    TextStyle ts = TextStyle(
      shadows: shadow == null ? [] : [shadow],
      fontSize: fontSize * config.fontSize,
      fontFamily: fontFamily.length == 1 ? fontFamily[0] : null,
      fontFamilyFallback: fontFamily,
      height: lineHeight * config.lineSpacing,
      color: textColor,
      fontWeight: fontWeight,
    );
    return TonoMargin(
        css: css,
        fontSize: fontSize,
        margin: margin ?? EdgeInsets.zero,
        child: Container(
            height: height,
            padding: padding,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                  width: borderWidth ?? 0,
                  color: borderColor ?? Color.fromARGB(0, 0, 0, 0)),
            ),
            child: lineHeight == 0 || tonoText.texts.isEmpty
                ? null
                : Text.rich(
                    TextSpan(children: [
                      TextSpan(text: indent),
                      ...tonoText.texts.map((e) {
                        return _rendeTextItem(e, ts, fontSize);
                      })
                    ]),
                    style: ts,
                    textAlign:
                        css["text-align"] == 'center' ? TextAlign.center : null,
                  )));
  }

  InlineSpan _rendeTextItem(TextItem textItem, TextStyle ts, double em) {
    if (textItem.css.isEmpty) {
      return TextSpan(text: textItem.text, style: ts);
    }
    var css = textItem.css.toMap();
    var config = Get.find<TonoReaderConfig>();
    var fontSize = fontSizeParse(css['font-size'], em);
    var lineHeight = (parseLineHeight(css['line-height'], fontSize) ?? 1);
    var fontWeight = parseFontWeight(css['font-weight']);
    var textColor = parseTextColor(css['color']);
    var shadow = parseTextShadow(css['text-shadow'], fontSize);
    var backgroundColor = parseBackgroundColor(css['background-color']);
    var margin = parseMarginAll(css, fontSize);
    var padding = parsePaddingAll(css, fontSize);
    return WidgetSpan(
        baseline: TextBaseline.alphabetic,
        alignment: PlaceholderAlignment.baseline,
        child: TonoMargin(
          fontSize: fontSize,
          css: css,
          margin: margin ?? EdgeInsets.zero,
          child: Container(
              color: backgroundColor,
              padding: padding,
              child: Text(
                textItem.text,
                style: TextStyle(
                  shadows: shadow == null ? [] : [shadow],
                  fontSize: fontSize * config.fontSize,
                  height: lineHeight * config.lineSpacing,
                  color: textColor,
                  fontWeight: fontWeight,
                ),
              )),
        ));
  }
}
