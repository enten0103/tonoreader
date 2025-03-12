import 'package:flutter/material.dart';
import 'package:voidlord/model/book_detail.dart';

class DetailStatistics extends StatelessWidget {
  const DetailStatistics({super.key, required this.bookDetailStatistics});

  final BookDetailStatistics bookDetailStatistics;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Row(
              children: [
                Text(bookDetailStatistics.score.toString()),
                Icon(
                  Icons.star,
                  size: 18,
                )
              ],
            ),
            Text("${bookDetailStatistics.comments}人评分"),
          ],
        ),
        SizedBox(height: 30, child: VerticalDivider(color: Colors.grey)),
        Column(
          children: [
            Icon(Icons.book_outlined),
            Text(bookDetailStatistics.type),
          ],
        ),
        SizedBox(height: 30, child: VerticalDivider(color: Colors.grey)),
        Column(
          children: [
            Icon(Icons.favorite_outline),
            Text(bookDetailStatistics.collections.toString()),
          ],
        ),
        SizedBox(height: 30, child: VerticalDivider(color: Colors.grey)),
        Column(
          children: [
            Icon(Icons.share),
            Text("分享"),
          ],
        ),
      ],
    );
  }
}
