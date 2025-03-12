import 'package:flutter/material.dart';
import 'package:voidlord/model/book_detail.dart';

class DetailHead extends StatelessWidget {
  const DetailHead({
    super.key,
    required this.bookDetailHead,
  });

  final BookDetailHead bookDetailHead;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bookDetailHead.title.value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        if (bookDetailHead.author?.value != null)
          Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                bookDetailHead.author!.value,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
        if (bookDetailHead.publisher?.value != null)
          Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                bookDetailHead.publisher!.value,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                ),
              )),
        if (bookDetailHead.customize != null)
          ...bookDetailHead.customize!.map((e) {
            return Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ));
          })
      ],
    );
  }
}
