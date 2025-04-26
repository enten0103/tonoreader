import 'dart:ui';

import 'package:get/instance_manager.dart';
import 'package:path/path.dart' as p;
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/render/state/tono_parent_size_cache.dart';
import 'package:voidlord/tono_reader/state/tono_assets_provider.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/state/tono_prepager.dart';
import 'package:voidlord/tono_reader/state/tono_progresser.dart';

class TonoInitializer {
  static init(Tono tono) async {
    _loadFont(tono);
    _loadState();
    _loadConfig();
    await _initData(tono);
  }

  static Future<void> _loadFont(Tono tono) async {
    var fonts = await tono.widgetProvider.getAllFont();
    for (var font in fonts.entries) {
      var fontName = p.basenameWithoutExtension(font.key);
      await loadFontFromList(font.value, fontFamily: tono.hash + fontName);
    }
  }

  static _loadState() {
    Get.put(TonoAssetsProvider());
    Get.put(TonoProgresser());
    Get.put(TonoParentSizeCache());
    Get.put(TonoPrepager());
  }

  static _loadConfig() {
    Get.put(TonoReaderConfig());
  }

  static _initData(Tono tono) async {
    await Get.find<TonoProvider>().init(tono);
  }
}
