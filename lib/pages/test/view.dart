import 'package:flutter/material.dart';
import 'package:voidlord/components/ios_showcase/view.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: IOSShowCase(dates: [
          IOSShowCaseDate(
            bookId: "bookId1",
            imageUrl:
                "http://192.168.1.103:9000/koa-bucket/test/image/cover1.jpg",
          ),
          IOSShowCaseDate(
            bookId: "bookId2",
            imageUrl:
                "http://192.168.1.103:9000/koa-bucket/test/image/cover2.jpg",
          ),
          IOSShowCaseDate(
            bookId: "bookId3",
            imageUrl:
                "http://192.168.1.103:9000/koa-bucket/test/image/cover3.jpg",
          ),
          IOSShowCaseDate(
            bookId: "bookId4",
            imageUrl:
                "http://192.168.1.103:9000/koa-bucket/test/image/cover4.jpg",
          ),
          IOSShowCaseDate(
            bookId: "bookId4",
            imageUrl:
                "http://192.168.1.103:9000/koa-bucket/test/image/cover5.jpg",
          ),
        ]),
      ),
    );
  }
}
