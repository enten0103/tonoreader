import 'package:flutter/material.dart';

class CardBook extends StatefulWidget {
  const CardBook({super.key});

  @override
  State<CardBook> createState() => _CardBookState();
}

class _CardBookState extends State<CardBook> {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
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
        width: double.infinity,
        height: 2000,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(128),
                        offset: Offset(5, 5),
                        blurRadius: 10)
                  ]),
              height: 396,
              width: 264,
              child: Image.network(
                'http://192.168.1.102:9000/koa-bucket/5e75567f7325f032fd96e14fbc01f3b7/image/cover',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
