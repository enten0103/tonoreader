import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:voidlord/components/ios_showcase/view.dart';

class IosExpendCardRaw extends StatelessWidget {
  const IosExpendCardRaw({
    super.key,
    required this.date,
  });

  final IOSShowCaseDate date;

  @override
  Widget build(BuildContext context) {
    double imageWidth = 264;
    double imageHeight = 396;
    double cardWidth = Get.width * 0.9;
    double topGap = 60;
    return Stack(children: [
      Container(
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
        width: Get.width * 0.9 - 5,
        constraints: BoxConstraints(minHeight: Get.height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: topGap,
            ),
            SizedBox(
              height: imageHeight,
              width: imageWidth,
            ),
          ],
        ),
      ),
      Positioned(
          top: topGap,
          left: (cardWidth - imageWidth) / 2 - 5,
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(128),
                        offset: Offset(5, 5),
                        blurRadius: 10)
                  ]),
              height: imageHeight,
              width: imageWidth,
              child: Image.network(
                date.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          )),
    ]);
  }
}
