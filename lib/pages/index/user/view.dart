import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';
import 'package:sqflite/sqflite.dart';
import 'package:voidlord/model/book_reader_info.dart';
import 'package:voidlord/repo/database.dart';
import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: SizedBox(
      width: 200,
      height: 80,
      child: ElevatedButton(
          onPressed: () async {
            AppDatabase db = Get.find();
            try {
              await db.bookInfoDao.insertBookReaderInfo(BookReaderInfo(
                  bookHash: '1214', bookMarks: [], bookNotes: []));
            } on DatabaseException catch (e) {
              Logger logger = Get.find();
              logger.i(e.runtimeType);
            }
          },
          child: const Text("test")),
    )));
  }
}

class TestWidget5 extends StatelessWidget {
  const TestWidget5({super.key});
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class TestWidget4 extends StatelessWidget {
  const TestWidget4({super.key});
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

/// sized padding widget test
class TestWidget1 extends StatelessWidget {
  const TestWidget1({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text("123"),
    );
  }
}

class TestTonoContainer {
  static TonoWidget tonoWidget1() {
    return TonoContainer(
        className: "div",
        css: [
          TonoStyle(priority: 0, value: "18px", property: "font-size"),
          TonoStyle(priority: 0, value: "40px", property: "height"),
        ],
        display: 'block',
        children: [
          TonoText(
            text: "12345",
            css: [
              TonoStyle(priority: 0, value: "18px", property: "font-size"),
            ],
          )
        ]);
  }

  static TonoWidget tonoWidget2() {
    return TonoContainer(
        className: "p",
        css: [
          TonoStyle(priority: 0, value: "18px", property: "font-size"),
          TonoStyle(priority: 0, value: "20px", property: "height"),
          TonoStyle(priority: 0, value: "fit-content", property: "width")
        ],
        display: 'block',
        children: [
          TonoText(
            text: "12345",
            css: [
              TonoStyle(priority: 0, value: "18px", property: "font-size"),
            ],
          )
        ]);
  }
}
