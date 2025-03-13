import 'dart:convert';
import 'package:csslib/visitor.dart';
import 'package:voidlord/tono_reader/model/parser/tono_style_sheet_block.dart';
import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/tono_reader/parser/tono_selector_parser.dart';
import 'package:voidlord/tono_reader/tool/path_tool.dart';
import 'package:csslib/parser.dart' as csslib;

extension TonoStyleParser on TonoParser {
  /// 解析 CSS 文件，返回选择器及其规则的 List
  Future<List<TonoStyleSheetBlock>> parseCss(
      String filePath, String? cssStr) async {
    final cssContent = cssStr ??
        utf8.decode((await provider.getFileByPath(filePath))!.toList(),
            allowMalformed: true);

    List<TonoStyleSheetBlock> result = [];
    var stylesheet = csslib.parse(cssContent);

    for (var styleBlock in stylesheet.topLevels) {
      if (styleBlock is RuleSet) {
        final selectorPart = styleBlock.selectorGroup?.span?.text ?? '';

        if (selectorPart.isEmpty || selectorPart.contains("type*=\"check\"")) {
          continue;
        }

        // 解析 CSS 属性
        final properties = <String, String>{};
        final declarations = styleBlock.declarationGroup;

        for (final declaration in declarations.declarations) {
          if (declaration is! Declaration) continue; // 跳过无效声明

          final property = declaration.property;
          final value = declaration.span.text
              .replaceAll(property, "")
              .replaceAll(":", "");
          // 处理 margin 缩略声明
          if (property == 'margin') {
            properties.addAll(marginSegmentation(value));
          } else if (property == "border-width") {
            properties.addAll(borderWidthSegmentation(value));
          } else {
            properties[property] = value;
          }
        }
        var selector = parseSelector(selectorPart);
        var styleSheetBlock =
            TonoStyleSheetBlock(selector: selector, properties: properties);
        result.add(styleSheetBlock);
      }
      if (styleBlock is ImportDirective) {
        result.addAll(
            await parseCss(filePath.pathSplicing(styleBlock.import), null));
      }
    }

    return result;
  }

  Map<String, String> borderWidthSegmentation(String value) {
    while (value.startsWith(" ")) {
      value = value.substring(1, value.length);
    }
    final values = value.split(RegExp(r'\s+')); // 按空格分割值
    final length = values.length;
    Map<String, String> properties = {};
    String top, right, bottom, left;

    // 根据值的数量拆分 margin
    if (length == 1) {
      // 1个值：所有边都使用该值
      top = right = bottom = left = values[0];
    } else if (length == 2) {
      // 2个值：上下用第一个值，左右用第二个值
      top = bottom = values[0];
      right = left = values[1];
    } else if (length == 3) {
      // 3个值：上用第一个值，左右用第二个值，下用第三个值
      top = values[0];
      right = left = values[1];
      bottom = values[2];
    } else if (length == 4) {
      // 4个值：分别对应上、右、下、左
      top = values[0];
      right = values[1];
      bottom = values[2];
      left = values[3];
    } else {
      return properties;
    }

    // 将拆分后的值存入 properties
    properties['border-width-top'] = top;
    properties['border-width-right'] = right;
    properties['border-width-bottom'] = bottom;
    properties['border-width-left'] = left;
    return properties;
  }

  Map<String, String> marginSegmentation(String value) {
    while (value.startsWith(" ")) {
      value = value.substring(1, value.length);
    }

    final values = value.split(RegExp(r'\s+')); // 按空格分割值
    final length = values.length;
    Map<String, String> properties = {};
    String top, right, bottom, left;
    // 根据值的数量拆分 margin
    if (length == 1) {
      // 1个值：所有边都使用该值
      top = right = bottom = left = values[0];
    } else if (length == 2) {
      // 2个值：上下用第一个值，左右用第二个值
      top = bottom = values[0];
      right = left = values[1];
    } else if (length == 3) {
      // 3个值：上用第一个值，左右用第二个值，下用第三个值
      top = values[0];
      right = left = values[1];
      bottom = values[2];
    } else if (length == 4) {
      // 4个值：分别对应上、右、下、左
      top = values[0];
      right = values[1];
      bottom = values[2];
      left = values[3];
    } else {
      return properties;
    }
    // 将拆分后的值存入 properties
    properties['margin-top'] = top;
    properties['margin-right'] = right;
    properties['margin-bottom'] = bottom;
    properties['margin-left'] = left;
    return properties;
  }
}
