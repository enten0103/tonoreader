import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class RubyItem {
  RubyItem({
    required this.text,
    this.ruby,
  });
  final String text;
  final String? ruby;
}

class TonoRuby extends TonoWidget {
  TonoRuby({
    required this.texts,
    required this.css,
  });
  final List<RubyItem> texts;
  final List<TonoStyle> css;
}
