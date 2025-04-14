import 'package:flutter/widgets.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

extension TonoCssBackgroundColor on FlutterStyleFromCss {
  Color? get backgroundColor => _parseBackgroundColor();
  Color? _parseBackgroundColor() {
    var cssBackgroundColor = css['background-color']?.toValue();
    if (cssBackgroundColor == null) return null;
    return parseColor(cssBackgroundColor);
  }
}
