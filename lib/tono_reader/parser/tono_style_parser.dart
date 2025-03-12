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

    // 移除 CSS 注释
    var sanitizedContent = cssContent.replaceAll(
      RegExp(r'/\*[\s\S]*?\*/', multiLine: true),
      '',
    );

    //提取import
    final importRegex = RegExp(r'''@import\s+["\'](.+?)["\']\s*;''');

    // 提取所有匹配项
    Iterable<RegExpMatch> matches = importRegex.allMatches(cssContent);

    // 获取文件名列表
    List<String> fileNames = [];
    for (final match in matches) {
      if (match.groupCount >= 1) {
        fileNames.add(match.group(1)!);
      }
    }

    for (var i = 0; i < fileNames.length; i++) {
      result.addAll(await parseCss(filePath.pathSplicing(fileNames[i]), null));
    }

    sanitizedContent = sanitizedContent.replaceAll(importRegex, "");

    // 移除 @font-face
    sanitizedContent =
        sanitizedContent.replaceAll(RegExp(r'@font-face\s*\{\s*\}'), "");

    // 移除 @media 规则块
    while (sanitizedContent.contains("@media")) {
      var deep = 0;
      var index = sanitizedContent.indexOf("@media");
      do {
        index = sanitizedContent.indexOf(RegExp("{|}"), index + 1);
        var quot = sanitizedContent[index];
        if (quot == "{") {
          deep++;
        } else {
          deep--;
        }
      } while (deep != 0);
      sanitizedContent = sanitizedContent.replaceRange(
          sanitizedContent.indexOf("@media"), index + 1, "");
    }

    // 匹配 CSS 规则块
    final rulePattern = RegExp(
      r'\s*([^{]+)\s*\{\s*([^}]+?)\s*\}\s*',
      multiLine: true,
    );

    for (final match in rulePattern.allMatches(sanitizedContent)) {
      final selectorPart = match.group(1)?.trim() ?? '';
      final propertiesPart = match.group(2)?.trim() ?? '';
      if (selectorPart.isEmpty || propertiesPart.isEmpty) continue;

      // 解析 CSS 属性
      final properties = <String, String>{};
      final declarations = propertiesPart.split(';').map((d) => d.trim()).where(
            (d) => d.isNotEmpty,
          );

      for (final declaration in declarations) {
        final colonIndex = declaration.indexOf(':');
        if (colonIndex == -1) continue; // 跳过无效声明

        final property = declaration.substring(0, colonIndex).trim();
        final value = declaration.substring(colonIndex + 1).trim();

        // 处理 margin 缩略声明
        if (property == 'margin') {
          final values = value.split(RegExp(r'\s+')); // 按空格分割值
          final length = values.length;

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
            continue; // 无效的 margin 值，跳过处理
          }

          // 将拆分后的值存入 properties
          properties['margin-top'] = top;
          properties['margin-right'] = right;
          properties['margin-bottom'] = bottom;
          properties['margin-left'] = left;
        } else if (property == "border") {
        } else {
          // 非 margin 属性，直接存储
          properties[property] = value;
        }
      }

      var selector = parseSelector(selectorPart);
      var styleSheetBlock =
          TonoStyleSheetBlock(selector: selector, properties: properties);
      result.add(styleSheetBlock);
    }

    return result;
  }
}
