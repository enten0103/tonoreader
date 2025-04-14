import 'package:flutter/painting.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

extension TonoCssTransformOrigin on FlutterStyleFromCss {
  Alignment get transformOrigin => _parseTransformOrigin();

  ///
  /// css [ transform-origin ] -> flutter [Alignment]
  Alignment _parseTransformOrigin() {
    var origin = css['transform-origin']?.toValue();
    switch (origin) {
      case 'center':
        return Alignment.center;
      case 'top left':
        return Alignment.topLeft;
      case 'top right':
        return Alignment.topRight;
      case 'bottom left':
        return Alignment.bottomLeft;
      case 'bottom right':
        return Alignment.bottomRight;
      default:
        return Alignment.center; // 默认使用 center
    }
  }
}
