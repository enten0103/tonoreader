import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_state.dart';
import 'package:voidlord/tono_reader/render/state/tono_css_provider.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_css_border_bgc.dart';
import 'package:voidlord/tono_reader/state/tono_prepager.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';

/// 实现如下css
/// - width
/// - height
/// - max-width
/// - max-height
/// - padding
class TonoCssSizePadding extends StatelessWidget {
  const TonoCssSizePadding({
    super.key,
    this.fitContent,
    this.icss,
    this.icontainer,
    required this.child,
  });
  final List<TonoStyle>? icss;
  final TonoWidget? icontainer;
  final bool? fitContent;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    var cssProvider = Get.find<TonoCssProvider>();
    var containerState = Get.find<TonoContainerState>();
    var tonoContainer = icontainer ?? containerState.container;
    tonoContainer.sizedKey = key;
    var styles = icss ?? cssProvider.css;
    var css = styles.toMap();
    var em = styles.getFontSize();
    Rx<Size> parentSize = Size(0, 0).obs;
    var cssWidth = css['width']?.replaceAll("!important", "");
    var cssMaxWidth = css['max-width'];
    var cssHeight = css['height']?.replaceAll("!important", "");
    var cssMaxHeight = css['max-height']?.replaceAll("!important", "");
    tonoContainer.extra['hb'] = _parseHBorder(css, em, parentSize.value.width);
    tonoContainer.extra['vb'] = _parseVBorder(css, em, parentSize.value.width);
    return Obx(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        var ro =
            tonoContainer.parent?.sizedKey?.currentContext?.findRenderObject();
        if (ro != null) {
          var rb = ro as RenderBox;
          parentSize.value = rb.paintBounds.size;
        }
        if (tonoContainer.parent?.className == "body") {
          var prepager = Get.find<TonoPrepager>();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            var co = tonoContainer.sizedKey?.currentContext?.findRenderObject();
            if (co != null) {
              var crb = co as RenderBox;
              tonoContainer.extra['height'] = crb.paintBounds.size.height;
            }
            prepager.total--;
            if (prepager.total == 0) {
              prepager.paging();
            }
          });
        }
      });
      var height = _parseHeight(cssHeight, parentSize.value.height, em);
      var maxWidth = _parseWidth(cssMaxWidth, em, parentSize.value.width);
      if (maxWidth != null) {
        maxWidth -= tonoContainer.parent?.extra['hb'] ?? 0;
        if (maxWidth <= 0) {
          maxWidth = 0;
        }
      }
      var maxHeight = _parseHeight(cssMaxHeight, parentSize.value.height, em);
      if (maxHeight != null) {
        maxHeight -= tonoContainer.parent?.extra['vb'] ?? 0;
        if (maxHeight <= 0) {
          maxHeight = 0;
        }
      }
      var padding = parsePaddingAll(css, em, parentSize.value.width);
      var width = _parseWidth(cssWidth, em, parentSize.value.width);
      if (width != null) {
        width -= tonoContainer.parent?.extra['hb'] ?? 0;
        if (width <= 0) {
          width = 0;
        }
      }
      var container = Container(
        key: key,
        height: height,
        padding: padding,
        constraints: width == null
            ? BoxConstraints(
                maxWidth: maxWidth ?? double.infinity,
                minWidth: maxWidth == null ? double.infinity : 0,
                maxHeight: maxHeight ?? double.infinity,
              )
            : null,
        width: width,
        decoration: css.boxDecoration(em),
        child: child,
      );

      if (cssWidth?.contains("fit-content") ?? false || fitContent == true) {
        return IntrinsicWidth(child: container);
      }

      return container;
    });
  }

  double? _parseWidth(String? cssWidth, double em, double parent) {
    if (cssWidth == null ||
        cssWidth.contains("auto") ||
        cssWidth.contains("fit-content")) {
      return null;
    }
    return parseUnit(cssWidth, parent, em);
  }

  double _parseVBorder(Map<String, String> css, double em, double parent) {
    var top = 0.0;
    var bottom = 0.0;
    var bts = css['border-top-style'];
    if (bts != null && bts != "none") {
      var btw = css['border-top-width'];
      if (btw != null) {
        top += parseUnit(btw, parent, em);
      }
    }
    var bbs = css['border-bottom-style'];
    if (bbs != null && bbs != "none") {
      var bbw = css['border-bottom-width'];
      if (bbw != null) {
        bottom += parseUnit(bbw, parent, em);
      }
    }
    return top + bottom;
  }

  double _parseHBorder(Map<String, String> css, double em, double parent) {
    var left = 0.0;
    var right = 0.0;
    var bls = css['border-left-style'];
    if (bls != null && bls != "none") {
      var blw = css['border-left-width'];
      if (blw != null) {
        left += parseUnit(blw, parent, em);
      }
    }
    var brs = css['border-right-style'];
    if (brs != null && brs != "none") {
      var brw = css['border-right-width'];
      if (brw != null) {
        right += parseUnit(brw, parent, em);
      }
    }
    return left + right;
  }

  double? _parseHeight(String? cssHeight, double parent, double em) {
    if (cssHeight == null || cssHeight.contains("auto")) return null;

    cssHeight = cssHeight.replaceAll("!important", "");
    if (cssHeight.contains('em')) {
      double emValue = double.parse(cssHeight.replaceAll('em', '')) * em;
      return emValue;
    } else if (cssHeight.contains('px')) {
      double pxValue = double.parse(cssHeight.replaceAll('px', ''));
      return pxValue;
    } else if (cssHeight.contains('%')) {
      double percentage = double.parse(cssHeight.replaceAll('%', ''));
      return parent * percentage / 100.0;
    } else if (cssHeight.contains('vh')) {
      double vhValue = double.parse(cssHeight.replaceAll('vh', ''));
      return Get.mediaQuery.size.height * vhValue / 100;
    } else {
      return double.parse(cssHeight);
    }
  }

  EdgeInsets? parsePaddingAll(
      Map<String, String> css, double em, double parent) {
    List<EdgeInsets> margins = [];
    var width = parent;
    var marginLeft = parseMarginLetf(css['padding-left'], width, em);
    if (marginLeft != null) margins.add(marginLeft);
    var marginRight = parseMarginRight(css['padding-right'], width, em);
    if (marginRight != null) margins.add(marginRight);
    var marginTop = parseMarginTop(css['padding-top'], width, em);
    if (marginTop != null) margins.add(marginTop);
    var marginBottom = parseMarginBottom(css['padding-bottom'], width, em);
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
    try {
      return EdgeInsets.only(top: parseUnit(cssMarginTop, width, em));
    } catch (_) {
      return null;
    }
  }

  EdgeInsets? parseMarginBottom(
      String? cssMarginBottom, double width, double em) {
    if (cssMarginBottom == null) return null;
    if (cssMarginBottom == "auto") {
      return null;
    }
    try {
      return EdgeInsets.only(bottom: parseUnit(cssMarginBottom, width, em));
    } catch (_) {
      return null;
    }
  }
}
