import 'dart:ui';

import 'package:get/get_state_manager/get_state_manager.dart';

class TonoParentSizeCache extends GetxController {
  final Map<int, Size> _cache = {};

  Size? getSize(int key) {
    return _cache[key];
  }

  void setSize(int key, Size size) {
    _cache[key] = size;
  }

  void clear() {
    _cache.clear();
  }
}
