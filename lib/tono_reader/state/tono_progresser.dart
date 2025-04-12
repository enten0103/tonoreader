import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class TonoProgresser extends GetxController {
  var pageController = PageController(
    initialPage: 0,
  );

  var pageIndex = 1.obs;

  int totalPageCount = 0;

  int currentPageIndex = 0;

  int xhtmlIndex = 0;

  List<int> pageSequence = [];
}
