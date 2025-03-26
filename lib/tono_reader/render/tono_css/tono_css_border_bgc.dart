import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:path/path.dart';
import 'package:voidlord/tono_reader/state/tono_assets_provider.dart';
import 'package:voidlord/tono_reader/tool/async_memory_image.dart';
import 'package:voidlord/tono_reader/tool/botted_box_border.dart';
import 'package:voidlord/tono_reader/tool/box_decoration.dart';
import 'package:voidlord/tono_reader/tool/css_tool.dart';
import 'package:voidlord/tono_reader/tool/dashed_box_border.dart';

extension TonoCssBorderBgc on Map<String, String> {
  /// [BoxDecoration]
  /// 实现如下CSS
  /// - border
  /// - border-radius
  /// - background-color
  /// - background-image
  Decoration boxDecoration(double em) {
    var assetsProvider = Get.find<TonoAssetsProvider>();
    var bgi = _parseBackgroundImage();
    var color = _parseBackgroundColor();
    return TonoBoxDecoration(
      color: color,
      borderRadius: _parseBorderRadius(em),
      border: _parseBorder(em),
      image: color == null && bgi != null
          ? TonoDecorationImage(
              alignment: _parseBackgorundPosition() ?? Alignment.center,
              repeat: _parseBackgroundRepet(),
              size: _parseBackgroundSize(em) ?? BackgroundSize(),
              image: AsyncMemoryImage(
                assetsProvider.getAssetsById(bgi),
                cacheKey: bgi,
              ))
          : null,
    );
  }

  BackgroundSize? _parseBackgroundSize(double em) {
    var cssBackgroundSize = this['background-size'];
    if (cssBackgroundSize == null) return null;
    if (cssBackgroundSize.contains(",")) {
      return null;
    }
    cssBackgroundSize = cssBackgroundSize.replaceAll("!important", "").trim();

    if (cssBackgroundSize.contains("cover")) {
      return BackgroundSize(
        widthMode: BackgroundSizeMode.cover,
        heightMode: BackgroundSizeMode.cover,
      );
    }
    if (cssBackgroundSize.contains("contain")) {
      return BackgroundSize(
        widthMode: BackgroundSizeMode.contain,
        heightMode: BackgroundSizeMode.contain,
      );
    }
    var cbgsSplited = cssBackgroundSize.split(" ");
    if (cbgsSplited.length == 1) {
      var value = cbgsSplited[0];
      if (value.contains("%")) {
        var pv = double.parse(value.replaceAll("%", "")) / 100;
        return BackgroundSize.percentage(pv, pv);
      } else if (value.contains("auto")) {
        return BackgroundSize(
          heightMode: BackgroundSizeMode.auto,
          widthMode: BackgroundSizeMode.auto,
        );
      } else {
        var uv = parseUnit(value, 0, em);
        return BackgroundSize.fixed(uv, uv);
      }
    } else if (cbgsSplited.length == 2) {
      var widthValue = cbgsSplited[0];
      var heightValue = cbgsSplited[1];
      BackgroundSizeMode wm = BackgroundSizeMode.fixed;
      BackgroundSizeMode hm = BackgroundSizeMode.fixed;
      double wv = 0;
      double hv = 0;
      if (widthValue.contains("%")) {
        wv = double.parse(widthValue.replaceAll("%", "")) / 100;
        wm = BackgroundSizeMode.percentage;
      } else if (widthValue.contains("auto")) {
        wm = BackgroundSizeMode.auto;
      } else {
        wv = parseUnit(widthValue, 0, em);
      }
      if (heightValue.contains("%")) {
        hv = double.parse(heightValue.replaceAll("%", "")) / 100;
        hm = BackgroundSizeMode.percentage;
      } else if (heightValue.contains("auto")) {
        hm = BackgroundSizeMode.auto;
      } else {
        hv = parseUnit(widthValue, 0, em);
      }
      return BackgroundSize(
          widthMode: wm, heightMode: hm, widthValue: wv, heightValue: hv);
    }

    return null;
  }

  ImageRepeat _parseBackgroundRepet() {
    var cssRepet = this['background-repeat'];
    if (cssRepet == null) return ImageRepeat.noRepeat;
    if (cssRepet == "repeat") {
      return ImageRepeat.repeat;
    }
    return ImageRepeat.noRepeat;
  }

  AlignmentGeometry? _parseBackgorundPosition() {
    var cssBgp = this['background-position'];
    if (cssBgp == null) return null;
    if (cssBgp.contains("center")) {
      if (cssBgp.contains("left")) {
        return Alignment.centerLeft;
      }
      if (cssBgp.contains("right")) {
        return Alignment.centerRight;
      }
      if (cssBgp.contains("top")) {
        return Alignment.topCenter;
      }
      if (cssBgp.contains("bottom")) {
        return Alignment.bottomCenter;
      }
      return Alignment.center;
    }
    if (cssBgp.contains("bottom")) {
      if (cssBgp.contains("left")) {
        return Alignment.bottomLeft;
      }
      if (cssBgp.contains("right")) {
        return Alignment.bottomRight;
      }
      return Alignment.bottomLeft;
    }
    if (cssBgp.contains("top")) {
      if (cssBgp.contains("left")) {
        return Alignment.topLeft;
      }
      if (cssBgp.contains("right")) {
        return Alignment.topRight;
      }
    }
    return Alignment.centerLeft;
  }

  String? _parseBackgroundImage() {
    var cssBackgroundImage = this['background-image'] ?? this['background'];
    if (cssBackgroundImage == null) return null;
    final regex = RegExp(r'''url\(["\']?(.*?)["\']?\)''');
    var url = regex.firstMatch(cssBackgroundImage)?.group(1);
    if (url == null) return null;
    return basenameWithoutExtension(url);
  }

  Color? _parseBackgroundColor() {
    var cssBackgroundColor = this['background-color'];
    if (cssBackgroundColor == null) return null;
    return parseColor(cssBackgroundColor);
  }

  BorderRadius? _parseBorderRadius(double em) {
    var cssBorderRadius = this['border-radius'];
    if (cssBorderRadius == null) return null;
    return BorderRadius.circular(
        parseUnit(cssBorderRadius, Get.mediaQuery.size.width, em));
  }

  Color? _pc(String? cc) {
    if (cc == null) return null;
    return parseColor(cc);
  }

  BoxBorder? _parseBorder(double em) {
    var borderColor = _pc(this['border-color']) ??
        _pc(this['border-left-color']) ??
        _pc(this['border-right-color']) ??
        _pc(this['border-top-color']) ??
        _pc(this['border-bottom-color']) ??
        Colors.black;

    if (this['border-top-style']?.contains("dotted") ?? false) {
      return DottedBoxBorder(
        left: this['border-left-style'] == 'none'
            ? BorderSide.none
            : _parseBorderSide(em, "left", borderColor),
        right: this['border-right-style'] == 'none'
            ? BorderSide.none
            : _parseBorderSide(em, "right", borderColor),
        top: this['border-top-style'] == 'none'
            ? BorderSide.none
            : _parseBorderSide(em, "top", borderColor),
        bottom: this['border-bottom-style'] == 'none'
            ? BorderSide.none
            : _parseBorderSide(em, "bottom", borderColor),
      );
    }
    if (this['border-top-style']?.contains("dashed") ?? false) {
      return DashedBoxBorder(
        left: this['border-left-style'] == 'none'
            ? BorderSide.none
            : _parseBorderSide(em, "left", borderColor),
        right: this['border-right-style'] == 'none'
            ? BorderSide.none
            : _parseBorderSide(em, "right", borderColor),
        top: this['border-top-style'] == 'none'
            ? BorderSide.none
            : _parseBorderSide(em, "top", borderColor),
        bottom: this['border-bottom-style'] == 'none'
            ? BorderSide.none
            : _parseBorderSide(em, "bottom", borderColor),
      );
    }
    return Border(
      left: this['border-left-style'] == 'none'
          ? BorderSide.none
          : _parseBorderSide(em, "left", borderColor),
      right: this['border-right-style'] == 'none'
          ? BorderSide.none
          : _parseBorderSide(em, "right", borderColor),
      top: this['border-top-style'] == 'none'
          ? BorderSide.none
          : _parseBorderSide(em, "top", borderColor),
      bottom: this['border-bottom-style'] == 'none'
          ? BorderSide.none
          : _parseBorderSide(em, "bottom", borderColor),
    );
  }

  BorderSide _parseBorderSide(double em, String side, Color color) {
    //var style = this['border-$side-style'];
    var cssWidth = this['border-$side-width'];
    if (cssWidth == null || cssWidth == "0" || cssWidth == "0px") {
      return BorderSide.none;
    }
    var width = parseUnit(cssWidth, Get.mediaQuery.size.width, em);
    return BorderSide(
      color: color,
      width: width,
    );
  }
}
