import 'dart:ui';

import 'package:path/path.dart' as p;
import 'package:voidlord/tono_reader/render/tono_render.dart';

extension TonoFontLoader on TonoRender {
  Future<void> loadFont() async {
    var fonts = await widgetProvider.getAllFont();
    for (var font in fonts.entries) {
      var fontName = p.basenameWithoutExtension(font.key);
      await loadFontFromList(font.value, fontFamily: fontName);
    }
  }
}
