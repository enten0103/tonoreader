import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/model/widget/tono_image.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_state.dart';
import 'package:voidlord/tono_reader/render/state/tono_css_provider.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_css_size_padding_widget.dart';
import 'package:voidlord/tono_reader/render/widget/inline/tono_inline_render.dart';
import 'package:voidlord/tono_reader/state/tono_assets_provider.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';

extension TonoImageRender on TonoInlineRender {
  InlineSpan renderImage(TonoImage tonoImage) {
    var assetsProvider = Get.find<TonoAssetsProvider>();
    Get.find<TonoCssProvider>().updateCss(tonoImage.css);
    Get.find<TonoContainerState>().container = tonoImage;

    final css = tonoImage.css.toMap();
    final em = tonoImage.css.getFontSize();

    final width =
        css['width'] != null && (!(css['width']?.contains("auto") ?? true))
            ? parseUnit(css['width']!, Get.mediaQuery.size.width, em)
            : null;
    final height =
        css['height'] != null && (!(css['height']?.contains("auto") ?? true))
            ? parseUnit(css['height']!, Get.mediaQuery.size.height, em)
            : null;
    final assetId = p.basenameWithoutExtension(tonoImage.url);
    return WidgetSpan(
      baseline: TextBaseline.alphabetic,
      alignment: PlaceholderAlignment.aboveBaseline,
      child: FutureBuilder<Uint8List>(
        key: Key("${css['width']}@$hashCode"),
        future: assetsProvider.getAssetsById(assetId),
        builder: (context, snapshot) {
          final effectiveWidth = width;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container(
                width: effectiveWidth,
                color: Colors.grey,
                child: const Icon(Icons.error),
              );
            }
            return TonoCssSizePaddingWidget(
              child: Image.memory(
                snapshot.data!,
                height: height,
                width: effectiveWidth,
                fit: BoxFit.contain,
              ),
            );
          } else {
            return SizedBox(
              width: effectiveWidth,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

  double? parseMaxHeight(String? cssMaxHeight, double em) {
    if (cssMaxHeight == null) return null;
    cssMaxHeight = cssMaxHeight.replaceAll("!important", "");
    if (cssMaxHeight.endsWith("%")) {
      var value = double.parse(cssMaxHeight.replaceAll("%", ""));
      return Get.mediaQuery.size.height * value / 100;
    } else {
      return parseUnit(cssMaxHeight, Get.mediaQuery.size.width, em);
    }
  }
}
