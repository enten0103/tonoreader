import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/componets/expan_box.dart';
import 'package:voidlord/model/book_detail.dart';

class DetailAbout extends StatelessWidget {
  const DetailAbout({super.key, required this.bookDetailAbout});
  final BookDetailAbout bookDetailAbout;

  @override
  Widget build(BuildContext context) {
    var isOpen = false.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "关于此书",
              style: Get.textTheme.titleLarge,
            ),
            IconButton(
                onPressed: isOpen.toggle,
                icon: Obx(() => AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isOpen.value ? 0.25 : 0,
                    curve: Curves.easeInOut,
                    child: Icon(Icons.arrow_forward_ios)))),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          bookDetailAbout.value,
          style: Get.textTheme.bodyLarge,
        ),
        Obx(
          () {
            List<Widget> buildTags(List<BookTag> bookTags) {
              List<Widget> result = [];
              for (var i = 0; i < bookTags.length; i++) {
                var tag = bookTags[i];
                result.add(InkWell(
                  child: Text(tag.value),
                  onTap: () {},
                ));
                if (tag != bookTags.last) {
                  result.add(Text("/"));
                }
              }
              return result;
            }

            return ExpanBox(
              isOpen: isOpen.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 5.0,
                    children: [
                      ...bookDetailAbout.tags.map(
                        (e) => ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            minimumSize: Size(0, 35),
                            elevation: 0,
                          ),
                          child: Text(
                            e.value,
                            style: TextStyle(
                                color:
                                    Get.theme.colorScheme.onPrimaryContainer),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...bookDetailAbout.info.map(
                    (x) {
                      return Row(
                        children: [
                          Text(x.key),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                              child: Wrap(
                            alignment: WrapAlignment.end,
                            children: [...buildTags(x.value)],
                          ))
                        ],
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
