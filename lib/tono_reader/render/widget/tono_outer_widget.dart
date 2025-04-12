import 'package:flutter/widgets.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_provider.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_css_margin_widget.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_css_size_padding_widget.dart';

///
/// body+html元素渲染
/// 根容器渲染
/// bg相关暂不实现
///
/// 根元素不进行transform,无 [TonoCssTransform] 渲染
class TonoOuterWidget extends StatelessWidget {
  /// 根元素
  final TonoContainer root;

  TonoOuterWidget({
    super.key,
    required this.root,
  }) : assert(
          root.className == "html" &&
              root.children.length == 1 &&
              root.children[0].className == "body",
          "根元素dom结构应为 html-> body->...",
        );

  @override
  Widget build(BuildContext context) {
    return TonoContainerProvider(
      data: root,
      child: TonoCssMarginWidget(
          child: TonoCssSizePaddingWidget(
              child: TonoContainerProvider(
        data: root.children[0],
        child: TonoCssMarginWidget(
          child: TonoCssSizePaddingWidget(child: Text("123456")),
        ),
      ))),
    );
  }
}
