import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

///
/// 可解析的display属性
enum CssDisplay {
  block,
  flex,
}

///
///  css [display] 实现
extension TonoCssDisplay on FlutterStyleFromCss {
  /// css [display] -> flutter [ CssDisplay ]
  CssDisplay get display => _parseDisplay();
  CssDisplay _parseDisplay() {
    var raw = css['display'];
    if (raw == null) return CssDisplay.block;
    if (raw == "block") return CssDisplay.block;
    if (raw == "flex") return CssDisplay.flex;
    return CssDisplay.block;
  }
}
