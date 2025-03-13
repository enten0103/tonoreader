import 'package:flutter/material.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_image.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_margin.dart';
import 'package:voidlord/tono_reader/render/tono_css_render.dart';
import 'package:voidlord/tono_reader/render/tono_image_render.dart';
import 'package:voidlord/tono_reader/render/tono_render.dart';
import 'package:voidlord/tono_reader/render/tono_ruby_render.dart';
import 'package:voidlord/tono_reader/render/tono_text_render.dart';
import 'package:voidlord/tono_reader/render/tono_transform_render.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';
import 'package:voidlord/tono_reader/tool/reversed_column.dart';

///container
extension TonoContainerRender on TonoRender {
  Future<Widget> rendeContainer(TonoContainer tonoContainer, double em) async {
    var css = tonoContainer.css.toMap();

    List<Widget> children = [];
    var fontSize = parseFontSize(css['font-size'], em) ?? em;
    if (tonoContainer.children != null) {
      children.addAll(await Future.wait(tonoContainer.children!.map((x) async {
        if (x is TonoImage) {
          return await rendeImage(x, fontSize);
        }
        if (x is TonoText) {
          return rendeText(x, fontSize);
        }
        if (x is TonoRuby) {
          return rendeRuby(x, fontSize);
        }
        if (x is TonoContainer) {
          return rendeContainer(x, fontSize);
        }
        return Text("unkonwn widget");
      })));
    }

    var margin = parseMarginAll(css, fontSize);
    var padding = parsePaddingAll(css, fontSize);
    var height = parseHeight(css['height'], fontSize);
    Border? border;
    var borderLeft = parseBorderLeft(css['border-left'], fontSize);
    var borderAll = parseBorder(css['border'], fontSize);
    var borderWith = parseBorderWidth(css['border-with'], fontSize);
    var borderColor = parseBorderColor(css['border-color']);
    var borderRadius = parseBorderRadius(css['border-radius'], fontSize);
    var backgroundColor = parseBackgroundColor(css['background-color']);
    if (borderAll == null && borderWith != null) {
      border =
          Border.all(width: borderWith, color: borderColor ?? Colors.black);
    } else {
      border = borderAll;
    }
    var transform = css['transform'];
    var transformOrigin = css['transform-origin'];
    CrossAxisAlignment genCrossAlignment() {
      if (css['align-items'] == 'center') {
        return CrossAxisAlignment.center;
      }
      if (css['align-items'] == 'start') {
        return CrossAxisAlignment.start;
      }
      if (css['align-items'] == 'end') {
        return CrossAxisAlignment.end;
      }
      if (css['text-align'] == 'center') {
        return CrossAxisAlignment.center;
      }
      if (css['text-align'] == 'right') {
        return CrossAxisAlignment.end;
      }
      if (css['text-align'] == 'left') {
        return CrossAxisAlignment.start;
      }
      return CrossAxisAlignment.end;
    }

    var result = TonoMargin(
        css: css,
        fontSize: fontSize,
        margin: margin ?? EdgeInsets.zero,
        child: Container(
          height: height,
          padding: padding,
          decoration: BoxDecoration(
              border: border ?? borderLeft,
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius ?? 0)),
          child: ReversedColumn(
            mainAxisAlignment: css['justify-content'] == 'center'
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            crossAxisAlignment: genCrossAlignment(),
            children: children,
          ),
        ));

    if (transform != null && transformOrigin != null) {
      return TransformParser(
          transform: transform,
          transformOrigin: transformOrigin,
          child: result);
    }
    return result;
  }
}
