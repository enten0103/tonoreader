import 'package:flutter/cupertino.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

///
/// css align-items values
extension TonoCssAlignItem on FlutterStyleFromCss {
  ///
  /// css [align-items] => flutter [CrossAxisAlignment]
  CrossAxisAlignment get alignItems => _parseAlignItem();

  CrossAxisAlignment _parseAlignItem() {
    var raw = css['align-items']?.toValue();
    if (raw == null) return CrossAxisAlignment.start;
    return switch (raw) {
      "flex-start" => CrossAxisAlignment.start,
      "flex-end" => CrossAxisAlignment.end,
      "center" => CrossAxisAlignment.center,
      "stretch" => CrossAxisAlignment.stretch,
      "baseline" => CrossAxisAlignment.baseline,
      _ => CrossAxisAlignment.start,
    };
  }
}
