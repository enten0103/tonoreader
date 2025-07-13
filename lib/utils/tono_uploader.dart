import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:voidlord/api/book_api.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/widget_provider/local_tono_widget_provider.dart';

extension TonoUploader on Tono {
  Future upload() async {}

  toContent() {
    return {
      "hash": hash,
      "navItems": navItems.map((e) => e.toMap()).toList(),
      "xhtmls": xhtmls,
      "deepth": deepth,
    };
  }
}

extension WidgetUploader on LocalTonoWidgetProvider {
  Future upload() async {
    Api api = Get.find();
    for (var entry in fonts.entries) {
      // 上传字体
      await api.uploadPart(
        hash,
        entry.key,
        entry.value,
        "application/font-woff",
        "font",
      );
    }
    for (var entry in images.entries) {
      // 上传图片
      await api.uploadPart(
        hash,
        entry.key,
        entry.value,
        "image/${entry.key.split('.').last}",
        "image",
      );
    }
    for (var entry in widgets.entries) {
      // 上传xhtml
      await api.uploadPart(
        hash,
        entry.key,
        convertJsonToUint8List(entry.value.toMap()),
        "application/octet-stream",
        "widget",
      );
    }
  }
}

Uint8List convertJsonToUint8List(Map<String, dynamic> json) {
  String jsonString = jsonEncode(json);
  return Uint8List.fromList(utf8.encode(jsonString));
}

Map<String, dynamic> convertUint8ListToJson(Uint8List bytes) {
  String jsonString = utf8.decode(bytes);
  return jsonDecode(jsonString) as Map<String, dynamic>;
}
