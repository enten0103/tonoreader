import 'package:flutter/widgets.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_provider.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_tansform.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_transform_origin.dart';

/// 实现如下css
/// -transform
/// -transform-origin
class TonoCssTransformWidget extends StatelessWidget {
  final Widget child; // 要应用变换的子组件

  const TonoCssTransformWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var tw = context.tonoWidget;
    var fci = tw.css.convert();
    var transform = fci.transform;
    if (transform == null) {
      return child;
    }
    return Transform(
      alignment: fci.transformOrigin,
      transform: transform,
      child: child,
    );
  }
}
