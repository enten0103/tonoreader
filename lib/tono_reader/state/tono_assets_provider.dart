import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';

class TonoAssetsProvider extends GetxController {
  late var tp = Get.find<TonoProvider>();
  Future<Uint8List> getAssetsById(String id) async {
    return tp.tono.widgetProvider.getAssetsById(id);
  }
}
