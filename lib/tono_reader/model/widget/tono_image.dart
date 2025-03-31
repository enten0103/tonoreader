import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class TonoImage extends TonoWidget {
  TonoImage({
    required this.url,
    required this.css,
  });
  final String url;

  final List<TonoStyle> css;
  static TonoImage fromMap(Map<String, dynamic> map) {
    return TonoImage(
        url: map['url'] as String,
        css: (map['css'] as List).map((e) => TonoStyle.formMap(e)).toList());
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "_type": "tonoImage",
      'url': url,
      "css": css.map((item) => item.toMap()).toList(),
    };
  }
}
