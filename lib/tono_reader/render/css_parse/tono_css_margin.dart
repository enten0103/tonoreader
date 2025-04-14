import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

abstract class CssMargin {}

class ValuedCssMargin implements CssMargin {
  const ValuedCssMargin({required this.value});
  final double value;
}

class KeyWordCssMargin implements CssMargin {}

extension TonoCssMargin on FlutterStyleFromCss {
  CssMargin get magrinLeft => _parseMargin("left");
  CssMargin get marginRight => _parseMargin("right");
  CssMargin get marginTop => _parseMargin("top");
  CssMargin get matginBottom => _parseMargin("bottom");
  CssMargin _parseMargin(String direction) {
    var marginRaw = css['margin-$direction']?.toValue();
    if (marginRaw == null) return ValuedCssMargin(value: 0);
    if (marginRaw == "auto") {
      return KeyWordCssMargin();
    }
    if (direction == "left" || direction == "right") {
      return ValuedCssMargin(
          value: parseUnit(marginRaw, parentSize?.width, em));
    } else {
      return ValuedCssMargin(
          value: parseUnit(marginRaw, parentSize?.height, em));
    }
  }
}
