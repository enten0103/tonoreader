import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;
import 'package:logger/logger.dart';
import 'package:voidlord/tono_reader/model/parser/tono_style_sheet_block.dart';
import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_image.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/tono_reader/parser/tono_style_parser.dart';
import 'package:voidlord/tono_reader/parser/widget_parser/container_parser.dart';
import 'package:voidlord/tono_reader/tool/path_tool.dart';

extension TonoWidgetParser on TonoParser {
  Future<List<TonoStyleSheetBlock>> loacCss(
      dom.Document document, String filePath) async {
    ///加载css
    ///加载cssfile
    List<TonoStyleSheetBlock> css = [];
    var cssRelativeFilePath = document.head!.children
        .where((e) => e.attributes['rel'] == "stylesheet")
        .firstOrNull
        ?.attributes['href'];
    if (cssRelativeFilePath != null) {
      var cssPath = filePath.pathSplicing(cssRelativeFilePath);
      css.addAll(await parseCss(cssPath, null));
    }

    ///加载<style/>
    var styleElements = document.getElementsByTagName("style");
    for (var styleElement in styleElements) {
      css.addAll(await parseCss("", styleElement.text));
    }
    return css;
  }

  Future<TonoWidget> parseWidget(String filePath) async {
    var logger = Logger();
    logger.i("filePatt:$filePath widget parse start......");
    final htmlContent = await provider.getFileByPath(filePath);

    ///获取document
    var document = html.parse(htmlContent);
    var css = await loacCss(document, filePath);
    var htmlElement = document.getElementsByTagName("html").first;
    var result = toContainer(htmlElement, filePath, css, inheritStyles: [
      TonoStyle(priority: 0, value: "1em", property: "font-size")
    ]);
    addParent(result, null);
    return result;
  }

  void addParent(TonoWidget tw, TonoWidget? parent) {
    if (tw is TonoRuby || tw is TonoImage || tw is TonoText) {
      tw.parent = parent;
    } else if (tw is TonoContainer) {
      tw.parent = parent;
      if (tw.children != null) {
        for (var child in tw.children!) {
          if (child == tw.children!.last) {
            child.extra['last'] = true;
          }
          addParent(child, tw);
        }
      }
    }
  }
}
