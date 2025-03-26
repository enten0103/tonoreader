import 'dart:typed_data';

import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/widget_provider/tono_widget_provider.dart';

class LocalTonoWidgetProvider extends TonoWidgetProvider {
  final Map<String, TonoWidget> widgets;
  final Map<String, Uint8List> assets;
  LocalTonoWidgetProvider({
    required this.widgets,
    required this.assets,
  });
  @override
  Future<TonoWidget> getWidgetsById(String id) async {
    var result = widgets[id];
    if (result == null) {
      throw Exception("cannot find widgets by id:$id");
    }
    return result;
  }

  @override
  Future<Uint8List> getAssetsById(String id) async {
    var result = assets[id];
    if (result == null) {
      throw Exception("cannot find assets by id:$id");
    }
    return result;
  }

  @override
  Future<Map<String, Uint8List>> getAllFont() async {
    Map<String, Uint8List> result = {};
    for (var asset in assets.entries) {
      if (asset.key.endsWith("ttf")) {
        result[asset.key] = asset.value;
      }
    }
    return result;
  }
}
