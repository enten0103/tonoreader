import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class TonoContainer extends TonoWidget {
  TonoContainer({
    super.className,
    required this.css,
    required this.display,
    this.children,
  });

  ///block/inline
  String display;

  ///样式
  List<TonoStyle> css;

  ///子元素
  List<TonoWidget>? children;
}
