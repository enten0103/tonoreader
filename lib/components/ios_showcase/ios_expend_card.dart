import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:voidlord/components/ios_showcase/ios_expend_card_controller.dart';
import 'package:voidlord/components/ios_showcase/view.dart';

class IosExpendCard extends StatelessWidget {
  const IosExpendCard(
      {super.key,
      required this.date,
      required this.controller,
      this.expendState = false});

  final IOSShowCaseDate date;

  final IosExpendCardController controller;

  final bool expendState;

  @override
  Widget build(BuildContext context) {
    double initImageWidth = 140;
    double initImageHeight = 210;
    double imageWidth = 264;
    double imageHeight = 396;
    double cardWidth = Get.width * 0.9;
    double topGap = 60;
    if (expendState) {
      controller.animationController
          .animateTo(1.0, duration: const Duration(milliseconds: 0));
    }
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (context, child) {
        final topGapAnimation = Tween(
          begin: 0.0,
          end: topGap,
        ).animate(CurvedAnimation(
          parent: controller.animationController,
          curve: Curves.easeOutBack,
        ));
        final scaleXAnimation = Tween<double>(
          end: 1.0,
          begin: initImageWidth / cardWidth,
        ).animate(CurvedAnimation(
          parent: controller.animationController,
          curve: Curves.easeOutBack,
        ));
        final scaleYAnimation = Tween<double>(
          end: 1.0,
          begin: initImageHeight / Get.height,
        ).animate(CurvedAnimation(
          parent: controller.animationController,
          curve: Curves.easeOutBack,
        ));
        final imageWidthAnimation = Tween<double>(
          begin: initImageWidth,
          end: imageWidth,
        ).animate(CurvedAnimation(
          parent: controller.animationController,
          curve: Curves.easeOutBack,
        ));
        final imageHeightAnimation = Tween<double>(
          begin: initImageHeight,
          end: imageHeight,
        ).animate(CurvedAnimation(
          parent: controller.animationController,
          curve: Curves.easeOutBack,
        ));

        return Stack(children: [
          Transform.scale(
              scaleX: scaleXAnimation.value,
              scaleY: scaleYAnimation.value,
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.5, 0.5),
                        blurRadius: 0.3,
                      )
                    ]),
                width: Get.width * 0.9 - 10,
                constraints: BoxConstraints(minHeight: Get.height),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: topGapAnimation.value,
                    ),
                    SizedBox(
                      height: imageHeightAnimation.value,
                      width: imageWidthAnimation.value,
                    ),
                  ],
                ),
              )),
          Positioned(
              top: topGapAnimation.value,
              left: (cardWidth - imageWidthAnimation.value) / 2 - 5,
              child: GestureDetector(
                onTap: () => controller.toggleExpend(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(128),
                            offset: Offset(5, 5),
                            blurRadius: 10)
                      ]),
                  height: imageHeightAnimation.value,
                  width: imageWidthAnimation.value,
                  child: Image.network(
                    date.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
        ]);
      },
    );
  }
}
