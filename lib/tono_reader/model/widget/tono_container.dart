import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class TonoContainer extends TonoWidget {
  TonoContainer({
    required this.css,
    this.children,
  });

  ///样式
  List<TonoStyle> css;

  ///子元素
  List<TonoWidget>? children;
}
