import 'package:flutter/cupertino.dart';
import 'package:get/instance_manager.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_state.dart';
import 'package:voidlord/tono_reader/render/state/tono_css_provider.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_css_size_padding.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_css_transform.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_inline_render.dart';
import 'package:voidlord/tono_reader/tool/reversed_column.dart';

extension TonoContainerRender on TonoInlineRender {
  InlineSpan renderContainer(
    TonoContainer inlineWidget,
    bool currentChildIndented,
  ) {
    Get.find<TonoCssProvider>().updateCss(inlineWidget.css);
    var containerState = Get.find<TonoContainerState>();
    return WidgetSpan(
      baseline: TextBaseline.alphabetic,
      alignment: PlaceholderAlignment.baseline,
      child: TonoCssTransform(
        child: TonoCssSizePadding(
          fitContent: true,
          child: ReversedColumn(
              children: containerState.updateContainer(
            inlineWidget,
            indented: currentChildIndented,
          )),
        ),
      ),
    );
  }
}
