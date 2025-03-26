import 'package:flutter/widgets.dart';

abstract class TonoWidget {
  TonoWidget({
    this.className,
  });
  TonoWidget? parent;
  String? className;
  GlobalKey? sizedKey;
  Map<String, dynamic> extra = {};
}
