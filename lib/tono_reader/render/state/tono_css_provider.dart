import 'dart:ui';

import 'package:get/state_manager.dart';
import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';

class TonoCssProvider extends GetxController {
  final List<TonoStyle> css = [];
  Map<String, String> cssMap = {};
  void updateCss(List<TonoStyle> newCss) {
    css.clear();
    css.addAll(List.from(newCss));
    cssMap = newCss.toMap();
  }

  TextAlign getTextAlign() {
    if (cssMap['text-align']?.trim() == 'center') {
      return TextAlign.center;
    }
    if (cssMap['text-align'] == 'right') {
      return TextAlign.end;
    }
    if (cssMap['text-align'] == 'left') {
      return TextAlign.start;
    }
    return TextAlign.justify;
  }

  double? getLineHeight() {
    var em = css.getFontSize();
    return _parseLineHeight(cssMap['line-height'], em);
  }

  double? _parseLineHeight(String? cssLineHeight, double em) {
    if (cssLineHeight == null) return null;
    cssLineHeight = cssLineHeight.replaceAll("!important", "");
    if (cssLineHeight.contains('em')) {
      double emValue = double.parse(cssLineHeight.replaceAll('em', '')) * em;
      return emValue / em;
    } else if (cssLineHeight.contains('px')) {
      double pxValue = double.parse(cssLineHeight.replaceAll('px', ''));
      return pxValue / em;
    } else if (cssLineHeight.contains('%')) {
      double percentage = double.parse(cssLineHeight.replaceAll('%', ''));
      return percentage / 100.0;
    } else {
      return double.parse(cssLineHeight);
    }
  }
}
