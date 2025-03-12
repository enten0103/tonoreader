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
import 'package:voidlord/tono_reader/parser/tono_selector_macher.dart';
import 'package:voidlord/tono_reader/parser/tono_style_parser.dart';
import 'package:voidlord/tono_reader/tool/path_tool.dart';

extension TonoWidgetParser on TonoParser {
  Future<List<TonoWidget>> parseWidget(String filePath) async {
    var logger = Logger();
    logger.i("filePatt:$filePath widget parse start......");
    final htmlContent = await provider.getFileByPath(filePath);

    ///获取document
    var document = html.parse(htmlContent);

    ///解析html元素
    ///解析body

    ///加载css
    List<TonoStyleSheetBlock> css = [];
    var cssRelativeFilePath = document.head!.children
        .where((e) => e.attributes['rel'] == "stylesheet")
        .firstOrNull
        ?.attributes['href'];
    if (cssRelativeFilePath != null) {
      var cssPath = filePath.pathSplicing(cssRelativeFilePath);
      css.addAll(await parseCss(cssPath, null));
    }

    var styleElements = document.getElementsByTagName("style");
    for (var styleElement in styleElements) {
      css.addAll(await parseCss("", styleElement.text));
    }

    ///读取body下的元素
    ///将body的直接子元素解析为text或image
    var elements = document.body!.children;

    var theInheritStyles = matchAll(document.body!, css, null).where((e) {
      return e.property == 'color' ||
          e.property == 'text-align' ||
          e.property == "font-family" ||
          e.property == 'line-height';
    }).toList();

    List<TonoWidget> result = [];

    for (var element in elements) {
      ///仅解析nodeType=1
      if (element.nodeType != 1) continue;
      if (element.localName!.contains("h") ||
          element.localName == "p" ||
          element.localName == "hr") {
        ///h5-1或p元素解析为text
        result.add(toText(element, css, theInheritStyles));
      } else if (element.localName == "div") {
        ///div元素解析为Container
        result.add(toContainer(element, filePath, css, theInheritStyles));
      } else if (element.localName == "img") {
        result.add(toImage(element, filePath, css));
      }
    }
    return result;
  }

  TonoWidget toContainer(
    dom.Element containerElement,
    String currentPath,
    List<TonoStyleSheetBlock> css,
    List<TonoStyle>? inheritStyles,
  ) {
    var matchedCss = matchAll(containerElement, css, inheritStyles);
    var theInheritStyle = matchedCss.where((e) {
      return e.property == 'color' ||
          e.property == 'text-align' ||
          e.property == "font-family" ||
          e.property == 'line-height';
    });
    List<TonoWidget> childrenWidget = [];
    for (var element in containerElement.children) {
      if (element.nodeType != 1) continue;
      if (element.localName!.contains("h") ||
          element.localName == "p" ||
          element.localName == "hr") {
        ///h5-1或p元素解析为text
        childrenWidget.add(toText(element, css, theInheritStyle.toList()));
      } else if (element.localName == "div") {
        ///div元素解析为Container
        childrenWidget.add(
            toContainer(element, currentPath, css, theInheritStyle.toList()));
      } else if (element.localName == "img") {
        childrenWidget.add(toImage(element, currentPath, css));
      }
    }
    return TonoContainer(css: matchedCss, children: childrenWidget);
  }

  TonoWidget toText(
    dom.Element textElement,
    List<TonoStyleSheetBlock> css,
    List<TonoStyle>? inheritStyles,
  ) {
    var matchedCss = matchAll(textElement, css, inheritStyles);

    ///加载用户代理样式表
    if (textElement.getElementsByTagName("ruby").isNotEmpty) {
      try {
        List<RubyItem> texts = [];
        var textNodes =
            textElement.nodes.where((e) => e.parentNode == textElement);
        for (var e in textNodes) {
          if (e.nodeType == 3) {
            texts.add(RubyItem(text: e.text!));
          } else {
            var ruby = e.nodes
                .where((x) => x.parentNode == e)
                .where((x) =>
                    x.nodeType != 1 || (x as dom.Element).localName == "rt")
                .where((x) => x.nodeType != 3 || x.text?.trim() != "")
                .toList();
            for (var i = 0; i < ruby.length; i += 2) {
              texts.add(RubyItem(
                  text: ruby[i].text!.trim(), ruby: ruby[i + 1].text?.trim()));
            }
          }
        }
        return TonoRuby(texts: texts, css: matchedCss);
      } catch (e) {
        return TonoText(
            texts: [TextItem(text: textElement.text, css: [])],
            css: matchedCss);
      }
    }
    List<TextItem> texts = [];
    var theInheritStyle = matchedCss.where((e) {
      return e.property == 'color' ||
          e.property == 'text-align' ||
          e.property == "font-family" ||
          e.property == 'line-height';
    });

    for (var node in textElement.nodes) {
      if (node.nodeType == 1) {
        if ((node as dom.Element).localName == 'span' ||
            node.localName == 'a') {
          var spanCss = matchAll(node, css, theInheritStyle.toList());
          texts.add(TextItem(text: node.text, css: spanCss));
        }
        if (node.localName == 'br') {
          texts.add(TextItem(text: "\n", css: []));
        }
      }

      if (node.nodeType == 3) {
        texts.add(TextItem(text: node.text ?? "", css: []));
      }
    }
    return TonoText(texts: texts, css: matchedCss);
  }

  TonoWidget toImage(
    dom.Element imageElement,
    String currentPath,
    List<TonoStyleSheetBlock> css,
  ) {
    var matchedCss = matchAll(imageElement, css, null);

    var imageUrl = "";
    var imageSrc = imageElement.attributes['src'];
    if (imageSrc != null) {
      imageUrl = currentPath.pathSplicing(imageSrc);
    }
    return TonoImage(url: imageUrl, css: matchedCss, contentCss: []);
  }
}
