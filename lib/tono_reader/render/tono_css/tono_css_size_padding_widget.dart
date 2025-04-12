import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_provider.dart';
import 'package:voidlord/tono_reader/render/tools/tono_css_converter.dart';
import 'package:voidlord/tono_reader/render/tools/tono_css_height.dart';
import 'package:voidlord/tono_reader/render/tools/tono_css_padding.dart';
import 'package:voidlord/tono_reader/render/tools/tono_css_width.dart';

/// 实现如下css
/// - width
/// - height
/// - max-width
/// - max-height
/// - padding
class TonoCssSizePaddingWidget extends StatelessWidget {
  TonoCssSizePaddingWidget({
    super.key,
    required this.child,
  });
  final Widget child;
  final Map<String, dynamic> _debugFillProperties = {};
  @override
  Widget build(BuildContext context) {
    var tonoContainer = context.tonoWidget;
    GlobalKey key = GlobalKey();
    tonoContainer.sizedKey = key;
    var fci = tonoContainer.css.convert();

    /// fci -> FlutterCssImpl
    var cssWidth = fci.width;
    var cssMaxWidth = fci.maxWidth;
    var cssHeight = fci.height;
    var cssMaxHeight = fci.maxHeight;

    EdgeInsets padding = fci.padding;

    /// valued css
    double? width;
    double? height;
    double? maxHeight;
    double? maxWidth;

    ///
    /// debug 注册
    _debugFillProperties['height'] = cssHeight;
    _debugFillProperties['width'] = cssWidth;
    _debugFillProperties['max-width'] = cssMaxWidth;
    _debugFillProperties['max-height'] = cssMaxHeight;
    _debugFillProperties['padding'] = padding;

    if (cssMaxHeight is ValuedCssHeight) {
      maxHeight = cssMaxHeight.value;
    }

    if (cssMaxWidth is ValuedCssWidth) {
      maxWidth = cssMaxWidth.value;
    }

    if (cssWidth is ValuedCssWidth) {
      width = cssWidth.value;
    }

    if (cssHeight is ValuedCssHeight) {
      height = cssHeight.value;
    }

    return Container(
      key: key,
      padding: padding,
      height: height,
      width: width,
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? double.infinity,
        maxWidth: maxWidth ?? double.infinity,
      ),
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
      DiagnosticsProperty<CssWidth>("width", _debugFillProperties['width']),
    );
    properties.add(
      DiagnosticsProperty<CssHeight>("height", _debugFillProperties['height']),
    );
    properties.add(DiagnosticsProperty<CssWidth>(
        "max-width", _debugFillProperties["max-width"]));
    properties.add(
      DiagnosticsProperty<CssHeight>(
          "max-height", _debugFillProperties['max-height']),
    );
    properties.add(
      DiagnosticsProperty<EdgeInsets>(
          "padding", _debugFillProperties['padding']),
    );

    super.debugFillProperties(properties);
  }
}
