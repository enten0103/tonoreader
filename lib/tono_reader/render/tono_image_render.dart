import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/model/widget/tono_image.dart';
import 'package:voidlord/tono_reader/render/tono_css_render.dart';
import 'package:voidlord/tono_reader/render/tono_render.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';

extension ImageRender on TonoRender {
  Future<Widget> rendeImage(TonoImage tonoImage, double em) async {
    var css = tonoImage.css.toMap();
    var width = parseWidth(css['width'], em);
    return Image.memory(
      await widgetProvider.getAssetsById(tonoImage.url),
      width: width ?? Get.mediaQuery.size.width - 40, // 固定高度
      fit: BoxFit.cover,
    );
  }
}
