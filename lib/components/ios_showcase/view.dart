import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:voidlord/components/ios_showcase/animation.dart';
import 'package:voidlord/components/ios_showcase/expend_card_view.dart';
import 'package:voidlord/components/ios_showcase/showcase_controller.dart';

class IOSShowCaseDate {
  const IOSShowCaseDate({
    required this.bookId,
    required this.imageUrl,
  });
  final String bookId;
  final String imageUrl;
}

class IOSShowCase extends StatefulWidget {
  const IOSShowCase({
    super.key,
    required this.dates,
  });
  final List<IOSShowCaseDate> dates;
  @override
  State<IOSShowCase> createState() => _IOSShowCaseState();
}

class _IOSShowCaseState extends State<IOSShowCase>
    with SingleTickerProviderStateMixin {
  List<GlobalKey> cardKey = [];

  OverlayEntry? overlayEntry;

  var isExpend = false;

  int index = 0;

  AnimationStatus animationStatus = AnimationStatus.dismissed;

  double gap = Get.width - 360;

  late AnimationController animationController;

  void setTargetCardSizeAndOffset() {
    final showcaseController = Get.find<ShowcaseController>();
    final key = cardKey[index];
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      showcaseController.cardSize = renderBox.size;
      showcaseController.cardOffset = renderBox.localToGlobal(Offset.zero);
    }
  }

  void showOverlay() {
    setTargetCardSizeAndOffset();
    overlayEntry = OverlayEntry(
      builder: (context) => AnimatedOverlayContent(
        dates: widget.dates,
        index: index,
        gap: gap,
        animationController: animationController,
        onAnimationStateChange: (state) {
          animationStatus = state;
          if (state == AnimationStatus.dismissed) {
            closeAnimation();
            setState(() {
              isExpend = false;
            });
          } else if (state == AnimationStatus.completed) {
            Future.delayed(const Duration(milliseconds: 200), () {
              closeAnimation();
            });
            setState(() {
              isExpend = true;
            });
          }
        },
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  closeAnimation() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Get.put(ShowcaseController());
    cardKey.addAll(List.generate(widget.dates.length, (index) {
      return GlobalKey();
    }));
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  Widget buildPreview() {
    return ListView.separated(
      controller: ScrollController(),
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 40, right: 40),
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) {
        return Align(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: () {
                  this.index = index;
                  showOverlay();
                  animationController.forward();
                },
                child: Container(
                  key: cardKey[index],
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withAlpha(128),
                            offset: Offset(5, 5),
                            blurRadius: 10)
                      ]),
                  height: 210,
                  width: 140,
                  child: Image.network(
                    widget.dates[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                )),
          ],
        ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: Get.width - 280 - 80,
        );
      },
      itemCount: widget.dates.length,
    );
  }

  Widget buildExpend() {
    return ExpendCardView(dates: widget.dates);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (animationStatus != AnimationStatus.dismissed) {
            showOverlay();
            animationController.reverse();
          } else if (isExpend == false) {
            Get.back();
          }
        },
        canPop: false,
        child: isExpend ? buildExpend() : buildPreview());
  }
}
