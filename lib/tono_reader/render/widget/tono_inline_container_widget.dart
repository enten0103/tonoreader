import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/utils.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_image.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/render/state/tono_css_provider.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_container_render.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_image_render.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_inline_render.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_text_render.dart';

class TonoInlineContainerWidget extends StatelessWidget {
  const TonoInlineContainerWidget({
    super.key,
    required this.inlineWidgets,
    this.indented = false,
  });

  final List<TonoWidget> inlineWidgets;
  final bool indented;
  @override
  Widget build(BuildContext context) {
    var cssProvider = Get.find<TonoCssProvider>();
    var inlineRender = TonoInlineRender();
    bool currentIndented = indented;
    List<InlineSpan> spans = [];
    for (final widget in inlineWidgets) {
      if (widget is TonoText) {
        final result = inlineRender.renderText(widget, currentIndented);
        spans.add(result.span);
        currentIndented = result.newIndented;
      } else if (widget is TonoContainer) {
        spans.add(inlineRender.renderContainer(widget, currentIndented));
      } else if (widget is TonoImage) {
        spans.add(inlineRender.renderImage(widget));
      } else {
        spans.add(const TextSpan(text: "unknown widget"));
      }
    }

    return Text.rich(
      TextSpan(children: spans),
      textAlign: cssProvider.getTextAlign(),
    );
  }
}
