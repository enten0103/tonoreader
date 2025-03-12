import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:ruby_text/ruby_text.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_margin.dart';
import 'package:voidlord/tono_reader/render/tono_css_render.dart';
import 'package:voidlord/tono_reader/render/tono_render.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';

extension RubyRender on TonoRender {
  Widget rendeRuby(TonoRuby tonoRuby, double em) {
    var config = Get.find<TonoReaderConfig>();
    var css = tonoRuby.css.toMap();
    var fontSize = fontSizeParse(css['font-size'], em);

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

    var lineHeight = (parseLineHeight(css['line-height'], fontSize) ?? 1);
    var fontWeight = parseFontWeight(css['font-weight']);
    var height = parseHeight(css['height'], fontSize);
    var margin = parseMarginAll(css, fontSize);

    return TonoMargin(
        css: css,
        fontSize: fontSize,
        margin: margin ?? EdgeInsets.zero,
        child: SizedBox(
            width: double.infinity,
            height: height,
            child: lineHeight == 0
                ? null
                : RubyText(
                    rtds,
                    style: TextStyle(
                      fontSize: fontSize * config.fontSize,
                      height: lineHeight * config.lineSpacing,
                      fontWeight: fontWeight,
                    ),
                    textAlign:
                        css["text-align"] == 'center' ? TextAlign.center : null,
                    rubyStyle: TextStyle(height: config.rubySize),
                  )));
  }
}
