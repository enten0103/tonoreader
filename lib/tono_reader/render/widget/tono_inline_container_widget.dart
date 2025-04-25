import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_image.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/render/css_impl/tono_css_widget.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_container_render.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_image_render.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_text_render.dart';

class TonoInlineContainerWidget extends TonoCssWidget {
  TonoInlineContainerWidget({
    super.key,
    required this.inlineWidgets,
    this.indented = false,
  });

  final List<TonoWidget> inlineWidgets;
  final bool indented;
  @override
  Widget content(BuildContext context) {
    bool currentIndented = indented;
    List<InlineSpan> spans = [];
    for (final widget in inlineWidgets) {
      if (widget is TonoText) {
        final result = renderText(context, widget);
        spans.add(result);
      } else if (widget is TonoContainer) {
        spans.add(renderContainer(widget, currentIndented));
      } else if (widget is TonoImage) {
        spans.add(renderImage(widget));
      } else {
        spans.add(const TextSpan(text: "unknown widget"));
      }
    }
    return Text.rich(
      TextSpan(children: spans),
      textAlign: textAlign,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
      DiagnosticsProperty("textAlign", textAlign),
    );
    super.debugFillProperties(properties);
  }
}
