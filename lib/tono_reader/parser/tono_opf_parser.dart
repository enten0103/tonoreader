import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/model/base/tono_book_info.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/tono_reader/parser/tono_widget_parser.dart';
import 'package:voidlord/tono_reader/tool/path_tool.dart';
import 'package:voidlord/tono_reader/tool/unit8_tool.dart';
import 'package:voidlord/tono_reader/widget_provider/local_tono_widget_provider.dart';
import 'package:xml/xml.dart';

extension TonoOpfParser on TonoParser {
  Future<Tono> parseOpf() async {
    var currentDir = await provider.getOpf();
    var xmlContent = (await provider.getFileByPath(currentDir))!.toUtf8();
    var document = XmlDocument.parse(xmlContent);
    var manifest = document.findAllElements("manifest").first;
    var parseItemResult = await parseItem(manifest, currentDir);
    var title = document.findAllElements("dc:title").first.innerText;
    TonoBookInfo tonoBookInfo =
        TonoBookInfo(title: title, coverUrl: parseItemResult[4]);
    List<TonoNavItem> tonoNavItems = parseItemResult[3];
    var ltwp = LocalTonoWidgetProvider(
        hash: provider.hash,
        widgets: parseItemResult[0],
        images: parseItemResult[1],
        fonts: parseItemResult[2]);
    var spine = document.findAllElements("spine").first;
    var xhtmls = await parseXhtmlList(
      spine,
      parseItemResult[5],
      currentDir,
    );
    return Tono(
      bookInfo: tonoBookInfo,
      navItems: tonoNavItems,
      widgetProvider: ltwp,
      xhtmls: xhtmls,
      hash: provider.hash,
    );
  }

  Future<List<String>> parseXhtmlList(
      XmlElement spine, Map<String, String> idmap, String currentDir) async {
    var items = spine.findAllElements('itemref');
    List<String> result = [];
    for (var item in items) {
      if (item.getAttribute('linear') != "no") {
        var idref = item.getAttribute("idref");
        if (idref != null && idref.endsWith("xhtml")) {
          result.add(idmap[idref]!);
        }
      }
    }
    return result;
  }

  Future<List<dynamic>> parseItem(
      XmlElement manifest, String currentDir) async {
    Map<String, TonoWidget> widgets = {};
    Map<String, Uint8List> images = {};
    Map<String, Uint8List> fonts = {};

    List<TonoNavItem> navItems = [];
    String coverUrl = "";
    Map<String, String> idmap = {};
    var items = manifest.findAllElements("item");
    for (var item in items) {
      var href = item.getAttribute("href");
      if (href == null) continue;
      var fullPath = currentDir.pathSplicing(href);
      if (href.endsWith("xhtml")) {
        idmap[item.getAttribute("id")!] = fullPath;
        widgets[fullPath] = await parseWidget(fullPath);
      }
      if (item.getAttribute("media-type")?.startsWith("image") ?? false) {
        if (item.getAttribute("id")?.startsWith("cover") ?? false) {
          coverUrl = p.basenameWithoutExtension(fullPath);
        }
        images[p.basenameWithoutExtension(fullPath)] =
            (await provider.getFileByPath(fullPath))!;
      }
      if (item.getAttribute("media-type")?.contains("font") ?? false) {
        fonts[p.basenameWithoutExtension(fullPath)] =
            (await provider.getFileByPath(fullPath))!;
      }
      if (href.endsWith("ncx")) {
        navItems.addAll(await parseNcx(fullPath));
      }
    }
    return [widgets, images, fonts, navItems, coverUrl, idmap];
  }

  Future<List<TonoNavItem>> parseNcx(String nxcPath) async {
    var currentDir = nxcPath;
    var ncxFile = await provider.getFileByPath(nxcPath);
    var document = XmlDocument.parse(ncxFile!.toUtf8());
    var navPoints = document.findAllElements("navPoint");
    return navPoints.map((e) {
      var textNode = e.findAllElements("text").first;
      var title = textNode.innerText;
      var src = e.findAllElements("content").first.getAttribute("src")!;
      var path = currentDir.pathSplicing(src);
      return TonoNavItem(path: path, title: title);
    }).toList();
  }
}
