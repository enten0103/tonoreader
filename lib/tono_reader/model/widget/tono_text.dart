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
  @override
  String toString() {
    return text;
  }
}
