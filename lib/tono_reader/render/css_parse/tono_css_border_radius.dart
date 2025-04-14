import 'package:flutter/widgets.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

extension TonoCssBorderRadius on FlutterStyleFromCss {
  BorderRadius? get borderRadius => _parseBorderRadius();
  BorderRadius? _parseBorderRadius() {
    var cssBorderRadius = css['border-radius']?.toValue();
    if (cssBorderRadius == null) return null;
    return BorderRadius.circular(
        parseUnit(cssBorderRadius, parentSize?.width, em));
  }
}
