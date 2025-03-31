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

  static TonoContainer fromMap(Map<String, dynamic> css) {
    return TonoContainer(
        className: css['className'] as String?,
        display: css['display'] as String,
        css: (css['css'] as List).map((e) => TonoStyle.formMap(e)).toList(),
        children: (css['children'] as List?)
            ?.map((e) => TonoWidget.fromMap(e))
            .toList());
  }

  @override
  Map<String, dynamic> toMap() {
    return children == null
        ? {
            "_type": "tonoContainer",
            "className": className,
            "css": css.map((item) => item.toMap()).toList(),
            "display": display,
          }
        : {
            "_type": "tonoContainer",
            "className": className,
            "css": css.map((item) => item.toMap()).toList(),
            "display": display,
            "children": children!.map((item) => item.toMap()).toList(),
          };
  }
}
