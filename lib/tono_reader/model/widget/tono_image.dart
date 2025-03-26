import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class TonoImage extends TonoWidget {
  TonoImage({
    required this.url,
    required this.css,
  });
  final String url;
  final List<TonoStyle> css;
}
