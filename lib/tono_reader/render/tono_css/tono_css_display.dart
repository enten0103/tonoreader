import 'package:flutter/widgets.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:voidlord/tono_reader/render/state/tono_css_provider.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';
import 'package:voidlord/tono_reader/tool/reversed_column.dart';

/// 实现如下CSS
/// - display
class TonoCssDisplay extends StatelessWidget {
  const TonoCssDisplay({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    var cssProvider = Get.find<TonoCssProvider>();
    var styles = cssProvider.css;
    var css = styles.toMap();

    return ReversedColumn(
      crossAxisAlignment: genCrossAxisAlignment(css),
      mainAxisAlignment: genMainAxisAlignment(css),
      children: children,
    );
  }

  CrossAxisAlignment genRowCrossAxisAlignment(Map<String, String> css) {
    if (css['justify-content'] == "center") {
      return CrossAxisAlignment.center;
    }
    return CrossAxisAlignment.start;
  }

  MainAxisAlignment genRowMainCrossAxisAlignment(Map<String, String> css) {
    if (css['margin-left']?.trim() == 'auto' || css['margin-right'] == 'auto') {
      return MainAxisAlignment.center;
    }
    if (css['justify-content']?.trim() == "center") {}
    if (css['text-align']?.trim() == 'center') {
      return MainAxisAlignment.center;
    }
    if (css['text-align'] == 'right') {
      return MainAxisAlignment.end;
    }
    return MainAxisAlignment.start;
  }

  MainAxisAlignment genMainAxisAlignment(Map<String, String> css) {
    if (css['justify-content']?.trim() == "center") {
      return MainAxisAlignment.center;
    }
    if (css['text-align']?.trim() == 'center') {
      return MainAxisAlignment.center;
    }
    return MainAxisAlignment.start;
  }

  CrossAxisAlignment genCrossAxisAlignment(Map<String, String> css) {
    if (css['justify-content'] == "center") {
      return CrossAxisAlignment.center;
    }
    if (css['text-align']?.trim() == 'center') {
      return CrossAxisAlignment.center;
    }
    if (css['text-align']?.trim() == 'right') {
      return CrossAxisAlignment.end;
    }
    return CrossAxisAlignment.start;
  }

  TextAlign? parseTextAlign(String? cssTextAlign) {
    if (cssTextAlign == null) return null;
    if (cssTextAlign == "center") {
      return TextAlign.center;
    }
    if (cssTextAlign == "right") {
      return TextAlign.end;
    }
    if (cssTextAlign == "left") {
      return TextAlign.start;
    }
    return null;
  }
}
