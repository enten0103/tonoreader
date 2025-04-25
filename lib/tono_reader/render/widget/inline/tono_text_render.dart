import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/render/state/tono_inline_state_provider.dart';
import 'package:voidlord/tono_reader/render/widget/tono_inline_container_widget.dart';

extension TonoTextRender on TonoInlineContainerWidget {
  InlineSpan renderText(
    BuildContext context,
    TonoText tonoText,
  ) {
    final config = Get.find<TonoReaderConfig>();
    TextStyle ts = TextStyle(
      shadows: textShadow == null ? [] : [textShadow!],
      fontSize: fontSize,
      fontFamily: fontFamily.isNotEmpty ? fontFamily[0] : null,
      textBaseline: TextBaseline.alphabetic,
      fontFamilyFallback: fontFamily,
      height: lineHeight * config.lineSpacing,
      color: color,
      fontWeight: fontWeight,
    );

    bool indented = context.indented;
    String text = tonoText.text;

    if (indented) {
      context.indented = true;
    } else if (tonoText.text == "\n") {
      context.indented = false;
    }

    return indented
        ? TextSpan(text: text, style: ts)
        : TextSpan(children: [
            WidgetSpan(
                child: SizedBox(
              width: (fontSize * (textIndent ?? 0)),
            )),
            TextSpan(text: text, style: ts)
          ]);
  }
}
