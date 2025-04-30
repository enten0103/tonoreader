import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TonoLeftDrawerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late PageController pageController = PageController()..addListener(() {});

  late TabController tabController = TabController(length: 3, vsync: this)
    ..addListener(() {
      if (tabController.indexIsChanging) {
        pageController.animateToPage(
          tabController.index,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    });

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
