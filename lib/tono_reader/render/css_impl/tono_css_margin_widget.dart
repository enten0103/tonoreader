import 'package:flutter/cupertino.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_provider.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_margin.dart';
import 'package:voidlord/tono_reader/tool/margin.dart';

/// 实现如下CSS
/// - margin*
class TonoCssMarginWidget extends StatelessWidget {
  final Widget child;
  const TonoCssMarginWidget({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    var tw = context.tonoWidget;
    var fci = tw.css.convert();
    var marginLeft = fci.magrinLeft;
    var marginRight = fci.marginRight;
    var marginTop = fci.marginTop;
    var marginBottom = fci.matginBottom;
    var left = marginLeft is ValuedCssMargin ? marginLeft.value : 0.0;
    var right = marginRight is ValuedCssMargin ? marginRight.value : 0.0;
    var top = marginTop is ValuedCssMargin ? marginTop.value : 0.0;
    var bottom = marginBottom is ValuedCssMargin ? marginBottom.value : 0.0;
    if (marginLeft is KeyWordCssMargin && marginRight is KeyWordCssMargin) {
      return Center(
        child: AdaptiveMargin(
          margin: EdgeInsets.only(top: top, bottom: bottom),
          child: child,
        ),
      );
    }
    return AdaptiveMargin(
        margin:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: child);
  }
}
