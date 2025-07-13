import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:voidlord/components/ios_showcase/showcase_controller.dart';
import 'package:voidlord/components/ios_showcase/view.dart';

class IosShowCaseDatePaintInfo {
  const IosShowCaseDatePaintInfo({
    required this.date,
    required this.dx,
    required this.dy,
  });
  final IOSShowCaseDate date;
  final double dx;
  final double dy;
}

class IosAniController extends GetxController {
  final AnimationController animationController;
  final List<IOSShowCaseDate> dates;
  final double gap;
  final List<IosShowCaseDatePaintInfo> paintInfos = [];
  final Function(AnimationStatus)? onAnimationStateChange;
  int clickedIndex;
  IosAniController({
    required this.clickedIndex,
    required this.animationController,
    required this.gap,
    required this.dates,
    this.onAnimationStateChange,
  });

  initDate() {
    animationController.addStatusListener((state) {
      onAnimationStateChange?.call(state);
    });
    var showcaseController = Get.find<ShowcaseController>();
    late IosShowCaseDatePaintInfo targetPaintInfo;
    late IosShowCaseDatePaintInfo prevPaintInfo;
    late IosShowCaseDatePaintInfo nextPaintInfo;
    final size = showcaseController.cardSize;
    final offset = showcaseController.cardOffset;
    targetPaintInfo = IosShowCaseDatePaintInfo(
      date: dates[clickedIndex % dates.length],
      dx: offset.dx,
      dy: offset.dy,
    );
    prevPaintInfo = IosShowCaseDatePaintInfo(
      date: dates[(clickedIndex - 1) % dates.length],
      dx: offset.dx - gap - size.width,
      dy: offset.dy,
    );
    nextPaintInfo = IosShowCaseDatePaintInfo(
      date: dates[(clickedIndex + 1) % dates.length],
      dx: offset.dx + gap + size.width,
      dy: offset.dy,
    );
    paintInfos.addAll([prevPaintInfo, targetPaintInfo, nextPaintInfo]);
  }

  @override
  void onInit() {
    initDate();
    super.onInit();
  }
}
