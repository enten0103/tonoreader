import 'package:flutter/material.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

extension TonoCssImageRepet on FlutterStyleFromCss {
  ImageRepeat get backgroundRepet => _parseBackgroundRepet();
  ImageRepeat _parseBackgroundRepet() {
    var cssRepet = css['background-repeat']?.toValue();
    if (cssRepet == null) return ImageRepeat.noRepeat;
    if (cssRepet == "repeat") {
      return ImageRepeat.repeat;
    }
    return ImageRepeat.noRepeat;
  }
}
