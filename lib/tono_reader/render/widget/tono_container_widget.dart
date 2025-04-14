import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_state.dart';
import 'package:voidlord/tono_reader/render/state/tono_css_provider.dart';
import 'package:voidlord/tono_reader/render/css_impl/tono_css_margin_widget.dart';
import 'package:voidlord/tono_reader/render/css_impl/tono_css_size_padding_widget.dart';
import 'package:voidlord/tono_reader/render/css_impl/tono_css_transform_widget.dart';
import 'package:voidlord/tono_reader/state/tono_flager.dart';
import 'package:voidlord/tono_reader/tool/constained_row.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';
import 'package:voidlord/tono_reader/tool/reversed_column.dart';

class TonoContainerWidget extends StatelessWidget {
  const TonoContainerWidget({
    super.key,
    required this.tonoContainer,
  });

  final TonoContainer tonoContainer;

  @override
  Widget build(BuildContext context) {
    Get.find<TonoCssProvider>().updateCss(tonoContainer.css);
    var flager = Get.find<TonoFlager>();
    var tonoContainerState = Get.find<TonoContainerState>();
    var children = tonoContainerState.updateContainer(tonoContainer);
    var css = tonoContainer.css.toMap();
    var result = TonoCssTransformWidget(
      key: Key(
          "preP:${tonoContainer.extra['preP']} nextP:${tonoContainer.extra['nextP']}@$hashCode"),
      child: TonoCssMarginWidget(
        child: TonoCssSizePaddingWidget(
          child: tonoContainer.className == "html"
              ? children[0]
              : tonoContainer.className == "body" && !flager.paging.value
                  ? ListView.builder(
                      itemCount: children.length,
                      itemBuilder: (ctx, index) {
                        return children[index];
                      })
                  : css['display'] == 'flex' || tonoContainer.className == 'tr'
                      ? ConstrainedRow(
                          mainAxisAlignment: genRowMainCrossAxisAlignment(css),
                          crossAxisAlignment: genRowCrossAxisAlignment(css),
                          children: children,
                        )
                      : ReversedColumn(
                          mainAxisAlignment: genMainAxisAlignment(css),
                          crossAxisAlignment: genCrossAxisAlignment(css),
                          children: children,
                        ),
        ),
      ),
    );
    if (css['width'] == null && tonoContainer.className == 'td') {
      return Expanded(child: Align(child: result));
    }
    return result;
  }

  CrossAxisAlignment genRowCrossAxisAlignment(Map<String, String> css) {
    if (css['justify-content'] == "center") {
      return CrossAxisAlignment.center;
    }
    return CrossAxisAlignment.start;
  }

  MainAxisAlignment genRowMainCrossAxisAlignment(Map<String, String> css) {
    if (css['margin-left']?.trim() == 'auto' || css['margin-right'] == 'auto') {
      return MainAxisAlignment.center;
    }
    if (css['justify-content']?.trim() == "center") {
      return MainAxisAlignment.center;
    }
    if (css['text-align']?.trim() == 'center') {
      return MainAxisAlignment.center;
    }
    if (css['text-align'] == 'right') {
      return MainAxisAlignment.end;
    }
    return MainAxisAlignment.start;
  }

  MainAxisAlignment genMainAxisAlignment(Map<String, String> css) {
    if (css['justify-content']?.trim() == "center") {
      return MainAxisAlignment.center;
    }
    if (css['text-align']?.trim() == 'center') {
      return MainAxisAlignment.center;
    }
    return MainAxisAlignment.start;
  }

  CrossAxisAlignment genCrossAxisAlignment(Map<String, String> css) {
    if (css['justify-content'] == "center") {
      return CrossAxisAlignment.center;
    }
    if (css['text-align']?.trim() == 'center') {
      return CrossAxisAlignment.center;
    }
    if (css['text-align']?.trim() == 'right') {
      return CrossAxisAlignment.end;
    }
    return CrossAxisAlignment.start;
  }

  TextAlign? parseTextAlign(String? cssTextAlign) {
    if (cssTextAlign == null) return null;
    if (cssTextAlign == "center") {
      return TextAlign.center;
    }
    if (cssTextAlign == "right") {
      return TextAlign.end;
    }
    if (cssTextAlign == "left") {
      return TextAlign.start;
    }
    return null;
  }
}
