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
  bool indentationEnable = false;

  ///ruby大小
  double rubySize = 0.5;

  ///视口设置
  ViewPortConfig viewPortConfig =
      ViewPortConfig(left: 20, right: 20, top: 0, bottom: 20);
}
