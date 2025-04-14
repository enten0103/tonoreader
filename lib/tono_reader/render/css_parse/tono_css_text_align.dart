import 'package:flutter/rendering.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

extension TonoCssTextAlign on FlutterStyleFromCss {
  TextAlign get textAlign => _parseTextAlign();
  TextAlign _parseTextAlign() {
    var raw = css['text-align']?.toValue();
    if (raw == null) return TextAlign.justify;
    return switch (raw) {
      "center" => TextAlign.center,
      "start" => TextAlign.start,
      "end" => TextAlign.end,
      "justify" => TextAlign.justify,
      _ => TextAlign.justify,
    };
  }
}
