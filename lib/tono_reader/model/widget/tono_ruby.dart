import 'package:voidlord/tono_reader/model/widget/tono_container.dart';

class RubyItem {
  RubyItem({
    required this.text,
    this.ruby,
  });
  final String text;
  final String? ruby;
}

class TonoRuby extends TonoContainer {
  TonoRuby({
    super.className,
    required super.css,
    required this.texts,
  }) : super(display: "block");
  final List<RubyItem> texts;
}
