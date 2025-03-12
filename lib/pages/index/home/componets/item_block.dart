import 'package:flutter/material.dart';
import 'package:voidlord/model/book_block.dart';
import 'package:voidlord/pages/index/home/componets/book_info.dart';

class ItemBlock extends StatelessWidget {
  const ItemBlock({super.key, required this.bookBlockModel});

  final BookBlockModel bookBlockModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bookBlockModel.title,
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.arrow_right_alt, size: 24)
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 250,
          child: PageView.builder(
              controller: PageController(viewportFraction: 0.9),
              itemCount: (bookBlockModel.books.length / 3).ceil(),
              itemBuilder: (_, index) => _buildPage(index)),
        ),
      ],
    );
  }

  Widget _buildPage(int pageIndex) {
    final start = pageIndex * 3;
    final end = (pageIndex + 1) * 3;
    final currentBooks = bookBlockModel.books.sublist(
      start,
      end < bookBlockModel.books.length ? end : bookBlockModel.books.length,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: currentBooks.map((book) {
        return BookInfo(bookInfoModel: book);
      }).toList(),
    );
  }
}
