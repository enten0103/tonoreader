import 'package:floor/floor.dart';
import 'package:voidlord/model/book_reader_info.dart';
import 'package:voidlord/model/dao/book_reader_info_dao.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:voidlord/repo/converter.dart';
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [BookReaderInfo])
abstract class AppDatabase extends FloorDatabase {
  BookReaderInfoDao get bookInfoDao;

  static Future<AppDatabase> getInstance() async {
    return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}
