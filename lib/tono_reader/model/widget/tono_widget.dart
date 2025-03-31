import 'package:flutter/widgets.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_image.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';

abstract class TonoWidget {
  TonoWidget({
    this.className,
    this.parent,
  });
  TonoWidget? parent;
  String? className;
  GlobalKey? sizedKey;
  Map<String, dynamic> extra = {};
  Map<String, dynamic> toMap();
  static TonoWidget fromMap(Map<String, dynamic> map) {
    var type = map['_type'];
    return switch (type) {
      "tonoContainer" => TonoContainer.fromMap(map),
      "tonoImage" => TonoImage.fromMap(map),
      "tonoRuby" => TonoRuby.formMap(map),
      "tonoText" => TonoText.formMap(map),
      _ => throw Error()
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
