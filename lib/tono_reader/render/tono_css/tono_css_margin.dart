import 'package:flutter/cupertino.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:voidlord/tono_reader/render/state/tono_css_provider.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';
import 'package:voidlord/tono_reader/tool/margin.dart';

/// 实现如下CSS
/// - margin*
class TonoCssMargin extends StatelessWidget {
  final Widget child;
  const TonoCssMargin({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    var cssProvider = Get.find<TonoCssProvider>();
    var styles = cssProvider.css;
    var css = styles.toMap();
    var fontSize = styles.getFontSize();
    var marginLeft = css['margin-left'];
    var marginRight = css['margin-right'];
    var marginTop = css['margin-top'];
    var marginBottom = css['margin-bottom'];
    if (marginLeft == null &&
        marginRight == null &&
        marginTop == null &&
        marginBottom == null) {
      return Container(
        child: child,
      );
    }

    if (marginLeft == "auto" && marginRight == "auto") {
      return Center(
        child: AdaptiveMargin(
          margin: parseMarginAll(css, fontSize) ?? EdgeInsets.zero,
          child: child,
        ),
      );
    }
    return AdaptiveMargin(
        margin: parseMarginAll(css, fontSize) ?? EdgeInsets.zero, child: child);
  }

  EdgeInsets? parseMarginAll(Map<String, String> css, double em) {
    List<EdgeInsets> margins = [];
    var width = Get.mediaQuery.size.width;
    var marginLeft = parseMarginLetf(css['margin-left'], width, em);
    if (marginLeft != null) margins.add(marginLeft);
    var marginRight = parseMarginRight(css['margin-right'], width, em);
    if (marginRight != null) margins.add(marginRight);
    var marginTop = parseMarginTop(css['margin-top'], width, em);
    if (marginTop != null) margins.add(marginTop);
    var marginBottom = parseMarginBottom(css['margin-bottom'], width, em);
    if (marginBottom != null) margins.add(marginBottom);
    if (margins.isEmpty) return null;
    double top = 0.0;
    double right = 0.0;
    double bottom = 0.0;
    double left = 0.0;
    for (EdgeInsets margin in margins) {
      top += margin.top;
      right += margin.right;
      bottom += margin.bottom;
      left += margin.left;
    }

    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  EdgeInsets? parseMarginLetf(String? cssMarginLeft, double width, double em) {
    if (cssMarginLeft == null) return null;
    if (cssMarginLeft == "auto") {
      return null;
    }
    return EdgeInsets.only(left: parseUnit(cssMarginLeft, width, em));
  }

  EdgeInsets? parseMarginRight(
      String? cssMarginRight, double width, double em) {
    if (cssMarginRight == null) return null;
    if (cssMarginRight == "auto") {
      return null;
    }
    return EdgeInsets.only(right: parseUnit(cssMarginRight, width, em));
  }

  EdgeInsets? parseMarginTop(String? cssMarginTop, double width, double em) {
    if (cssMarginTop == null) return null;
    if (cssMarginTop == "auto") {
      return null;
    }
    return EdgeInsets.only(top: parseUnit(cssMarginTop, width, em));
  }

  EdgeInsets? parseMarginBottom(
      String? cssMarginBottom, double width, double em) {
    if (cssMarginBottom == null) return null;
    if (cssMarginBottom == "auto") {
      return null;
    }

    return EdgeInsets.only(bottom: parseUnit(cssMarginBottom, width, em));
  }
}
