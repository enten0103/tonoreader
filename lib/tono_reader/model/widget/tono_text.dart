import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class TonoText extends TonoWidget {
  TonoText({
    super.className,
    required this.text,
    required this.css,
  });

  final String text;
  final List<TonoStyle> css;

  static TonoText formMap(Map<String, dynamic> map) {
    return TonoText(
      className: map['className'],
      text: map['text'] ?? '', // 提供默认值防止null
      css: List<TonoStyle>.from(
        (map['css'] as List).map((e) => TonoStyle.formMap(e)),
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "_type": "tonoText",
      'className': className,
      'text': text,
      'css': css.map((style) => style.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return text;
  }
}
