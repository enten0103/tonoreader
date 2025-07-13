import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/components/ios_showcase/ios_ani_controller.dart';
import 'package:voidlord/components/ios_showcase/ios_expend_card.dart';
import 'package:voidlord/components/ios_showcase/ios_expend_card_controller.dart';
import 'package:voidlord/components/ios_showcase/view.dart';

class AnimatedOverlayContent extends StatelessWidget {
  final int index;
  final List<IOSShowCaseDate> dates;
  final double gap;
  final Function(AnimationStatus)? onAnimationStateChange;
  final AnimationController animationController;

  const AnimatedOverlayContent({
    super.key,
    required this.index,
    required this.dates,
    required this.gap,
    required this.animationController,
    required this.onAnimationStateChange,
  });

  @override
  Widget build(BuildContext context) {
    IosAniController controller = Get.put(
        tag: hashCode.toString(),
        IosAniController(
            clickedIndex: index,
            animationController: animationController,
            onAnimationStateChange: onAnimationStateChange,
            gap: gap,
            dates: dates));

    return Material(
      child: AnimatedBuilder(
        animation: controller.animationController,
        builder: (context, child) {
          final positionAnimationPrev = Tween<Offset>(
            begin: Offset(controller.paintInfos[0].dx - (Get.width * 0.45 - 70),
                controller.paintInfos[0].dy),
            end: Offset(-Get.width * 0.9 + 25, 60),
          ).animate(CurvedAnimation(
            parent: controller.animationController,
            curve: Curves.easeOutBack,
          ));
          final positionAnimationCurrent = Tween<Offset>(
            begin: Offset(controller.paintInfos[1].dx - (Get.width * 0.45 - 70),
                controller.paintInfos[1].dy),
            end: Offset(25, 60),
          ).animate(CurvedAnimation(
            parent: controller.animationController,
            curve: Curves.easeOutBack,
          ));
          final positionAnimationNext = Tween<Offset>(
            begin: Offset(controller.paintInfos[2].dx - (Get.width * 0.45 - 70),
                controller.paintInfos[2].dy),
            end: Offset(Get.width * 0.9 + 25, 60),
          ).animate(CurvedAnimation(
            parent: controller.animationController,
            curve: Curves.easeOutBack,
          ));
          return Stack(
            children: [
              // 添加半透明背景（点击可关闭）
              GestureDetector(
                child: Container(
                  color: Color.lerp(Colors.transparent, Colors.black54,
                      controller.animationController.value), // 半透明背景
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                left: positionAnimationPrev.value.dx,
                top: positionAnimationPrev.value.dy,
                child: Align(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: IosExpendCard(
                          controller: IosExpendCardController(
                              animationController:
                                  controller.animationController),
                          date: dates[(index - 1) % dates.length]),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: positionAnimationCurrent.value.dx,
                top: positionAnimationCurrent.value.dy,
                child: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: IosExpendCard(
                        key: Key(dates[index].toString()),
                        controller: IosExpendCardController(
                            animationController:
                                controller.animationController),
                        date: dates[(index) % dates.length]),
                  ),
                ),
              ),
              Positioned(
                left: positionAnimationNext.value.dx,
                top: positionAnimationNext.value.dy,
                child: Align(
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: IosExpendCard(
                          controller: IosExpendCardController(
                              animationController:
                                  controller.animationController),
                          date: dates[(index + 1) % dates.length]),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
