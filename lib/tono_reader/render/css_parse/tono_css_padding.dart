import 'package:flutter/cupertino.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

///
/// css [padding] 转 flutter [EdgeInsets]
extension TonoCssPadding on FlutterStyleFromCss {
  EdgeInsets get padding => _parsePadding();

  EdgeInsets _parsePadding() {
    var left = _parsePaddingSide("left");
    var right = _parsePaddingSide("right");
    var top = _parsePaddingSide("top");
    var bottom = _parsePaddingSide("bottom");
    return EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);
  }

  ///
  /// padding关键词
  ///
  /// 若css pading值为keyword则不解析
  static List<String> globalKeyWords = [
    'inherit',
    'initial',
    "revert",
    "revert-layer",
    "unset"
  ];

  ///
  /// 单方向padding解析
  double _parsePaddingSide(String side) {
    var cssPadding = css['padding-$side'];
    if (cssPadding == null || globalKeyWords.contains(cssPadding)) {
      return 0;
    }
    var parent = (side == "left" || side == "right")
        ? parentSize?.width
        : parentSize?.height;
    return parseUnit(cssPadding, parent, em);
  }
}
