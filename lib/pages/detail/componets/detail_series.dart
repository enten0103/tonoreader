import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:voidlord/componets/book_cover.dart';
import 'package:voidlord/model/book_detail.dart';

class DetailSeries extends StatelessWidget {
  const DetailSeries({super.key, required this.bookDetailSeries});
  final BookDetailSeries bookDetailSeries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${bookDetailSeries.title}系列",
              style: Get.textTheme.titleLarge,
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 200,
          child: PageView.builder(
              itemCount: (bookDetailSeries.books.length / 3).ceil(),
              itemBuilder: (_, index) => _buildPage(index)),
        ),
      ],
    );
  }

  Widget _buildPage(int pageIndex) {
    final start = pageIndex * 3;
    final end = (pageIndex + 1) * 3;
    final currentBooks = bookDetailSeries.books.sublist(
      start,
      end < bookDetailSeries.books.length ? end : bookDetailSeries.books.length,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: currentBooks.map((book) {
        return Column(
          children: [
            BookCover(id: book.id, url: book.coverUrl),
            SizedBox(
              width: 110,
              child: Text(
                book.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}
