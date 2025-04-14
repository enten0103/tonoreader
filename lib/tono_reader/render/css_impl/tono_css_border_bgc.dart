import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_background_color.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_background_image.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_background_position.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_background_size.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_border.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_border_radius.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_box_shadow.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_image_repet.dart';
import 'package:voidlord/tono_reader/state/tono_assets_provider.dart';
import 'package:voidlord/tono_reader/tool/async_memory_image.dart';
import 'package:voidlord/tono_reader/tool/box_decoration.dart';

extension TonoCssBorderBgc on FlutterStyleFromCss {
  /// [BoxDecoration]
  /// 实现如下CSS
  /// - border
  /// - border-radius
  /// - background-color
  /// - background-image
  Decoration boxDecoration() {
    var assetsProvider = Get.find<TonoAssetsProvider>();
    return TonoBoxDecoration(
      color: backgroundColor ?? (boxShadow != null ? Colors.white : null),
      borderRadius: borderRadius,
      border: border,
      boxShadow: boxShadow != null ? [boxShadow!] : [],
      image: backgroundImage != null
          ? TonoDecorationImage(
              alignment: backgroundPosition ?? Alignment.center,
              repeat: backgroundRepet,
              size: backgroundSize ?? BackgroundSize(),
              image: AsyncMemoryImage(
                assetsProvider.getAssetsById(backgroundImage!),
                cacheKey: backgroundImage,
              ))
          : null,
    );
  }
}
