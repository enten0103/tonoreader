import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class IosExpendCardController extends GetxController {
  final AnimationController animationController;

  bool isExpend = false;

  IosExpendCardController({required this.animationController});
  void toggleExpend() {
    if (isExpend) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    isExpend = !isExpend;
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
