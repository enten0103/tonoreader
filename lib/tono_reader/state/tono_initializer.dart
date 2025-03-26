import 'dart:ui';

import 'package:get/instance_manager.dart';
import 'package:path/path.dart' as p;
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_state.dart';
import 'package:voidlord/tono_reader/render/state/tono_css_provider.dart';
import 'package:voidlord/tono_reader/state/tono_assets_provider.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/state/tono_progresser.dart';

class TonoInitializer {
  static init(Tono tono) async {
    _loadFont(tono);
    _loadState();
    _loadConfig();
    _initData(tono);
  }

  static Future<void> _loadFont(Tono tono) async {
    var fonts = await tono.widgetProvider.getAllFont();
    for (var font in fonts.entries) {
      var fontName = p.basenameWithoutExtension(font.key);
      await loadFontFromList(font.value,
          fontFamily: tono.fontPrefix + fontName);
    }
  }

  static _loadState() {
    Get.put(TonoCssProvider());
    Get.put(TonoAssetsProvider());
    Get.put(TonoContainerState());
    Get.put(TonoProgresser());
  }

  static _loadConfig() {
    Get.put(TonoReaderConfig());
  }

  static _initData(Tono tono) {
    Get.find<TonoProvider>().init(tono);
  }
}
