import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/components/expan_box.dart';
import 'package:voidlord/model/book_detail.dart';

class DetailChapter extends StatelessWidget {
  const DetailChapter({super.key, required this.bookDetailChapter});

  final BookDetailChapter bookDetailChapter;

  @override
  Widget build(BuildContext context) {
    var isOpen = false.obs;
    var chapterOuter = [];
    var chapterInner = [];
    if (bookDetailChapter.value.length >= 4) {
      chapterOuter.addAll(bookDetailChapter.value.sublist(0, 4));
      chapterInner.addAll(bookDetailChapter.value.sublist(4));
    } else {
      chapterOuter.addAll(bookDetailChapter.value);
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "章节",
              style: Get.textTheme.titleLarge,
            ),
            bookDetailChapter.value.length <= 4
                ? Container()
                : IconButton(
                    onPressed: isOpen.toggle,
                    icon: Obx(() => AnimatedRotation(
                        duration: const Duration(milliseconds: 200),
                        turns: isOpen.value ? 0.25 : 0,
                        curve: Curves.easeInOut,
                        child: Icon(Icons.arrow_forward_ios)))),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        GridView(
          shrinkWrap: true, // 自适应内容高度
          physics: NeverScrollableScrollPhysics(), // 禁止滚动
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10),
          children: [
            ...chapterOuter.map(
              (x) => ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(elevation: 0),
                  child: Text(
                    x.name,
                    style: TextStyle(
                        color: Get.theme.colorScheme.onPrimaryContainer),
                  )),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Obx(() => ExpanBox(
              isOpen: isOpen.value,
              child: GridView(
                shrinkWrap: true, // 自适应内容高度
                physics: NeverScrollableScrollPhysics(), // 禁止滚动
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                children: [
                  ...chapterInner.map(
                    (x) => ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(elevation: 0),
                        child: Text(
                          x.name,
                          style: TextStyle(
                            color: Get.theme.colorScheme.onPrimaryContainer,
                          ),
                        )),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
