import 'package:flutter/material.dart';
import 'package:voidlord/pages/index/home/componets/book_info.dart';
import 'package:voidlord/pages/index/home/module.dart';

class ItemBlock extends StatelessWidget {
  const ItemBlock({super.key, required this.bookBlockModule});

  final BookBlockModule bookBlockModule;

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
                bookBlockModule.title,
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.arrow_right_alt, size: 24)
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 240,
          child: PageView.builder(
              controller: PageController(viewportFraction: 0.9),
              itemCount: (bookBlockModule.books.length / 3).ceil(),
              itemBuilder: (_, index) => _buildPage(index)),
        ),
      ],
    );
  }

  Widget _buildPage(int pageIndex) {
    final start = pageIndex * 3;
    final end = (pageIndex + 1) * 3;
    final currentBooks = bookBlockModule.books.sublist(
      start,
      end < bookBlockModule.books.length ? end : bookBlockModule.books.length,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: currentBooks.map((book) {
        return BookInfo(bookInfoModule: book);
      }).toList(),
    );
  }
}
