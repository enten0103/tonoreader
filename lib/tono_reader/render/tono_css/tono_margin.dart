import 'package:flutter/cupertino.dart';
import 'package:voidlord/tono_reader/tool/margin.dart';

class TonoMargin extends StatelessWidget {
  final Map<String, String> css;
  final EdgeInsets? margin;
  final double fontSize;
  final Widget child;
  const TonoMargin({
    super.key,
    required this.css,
    this.margin,
    required this.fontSize,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
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
          margin: margin ?? EdgeInsets.zero,
          child: child,
        ),
      );
    }
    return AdaptiveMargin(margin: margin ?? EdgeInsets.zero, child: child);
  }
}
