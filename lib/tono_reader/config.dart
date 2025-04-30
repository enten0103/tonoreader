import 'dart:ui';

import 'package:voidlord/tono_reader/model/config.dart';

class TonoReaderConfig {
  ///翻页方式
  PageTurningMethod pageTurningMethod = PageTurningMethod.turn;

  ///自定义文字颜色
  String? fontColor;

  ///自定义字体
  String? customFont;

  ///字间距
  double wordSpacing = 1;

  ///字体大小
  double fontSize = 18;

  ///行间距
  double lineSpacing = 1;

  ///是否启用行首缩进
  bool indentationEnable = true;

  ///ruby大小
  double rubySize = 0.5;

  //markder颜色
  Color markerColor = Color.fromARGB(230, 192, 54, 69);

  ///视口设置
  ViewPortConfig viewPortConfig =
      ViewPortConfig(left: 25, right: 25, top: 40, bottom: 40);
}
