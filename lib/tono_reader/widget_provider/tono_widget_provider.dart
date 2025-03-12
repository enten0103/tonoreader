import 'dart:typed_data';

import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

abstract class TonoWidgetProvider {
  Future<List<TonoWidget>> getWidgetsById(String id);
  Future<Uint8List> getAssetsById(String id);
  Future<Map<String, Uint8List>> getAllFont();
}
