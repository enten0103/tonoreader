import 'package:floor/floor.dart';
import 'package:voidlord/model/book_reader_info.dart';

@dao
abstract class BookReaderInfoDao {
  @Query('SELECT * FROM BookReaderInfo WHERE bookHash = :bookHash')
  Future<BookReaderInfo?> findByBookHash(String bookHash);

  @insert
  Future<void> insertBookReaderInfo(BookReaderInfo bookReaderInfo);

  @update
  Future<void> updateBookReaderInfo(BookReaderInfo bookReaderInfo);

  @delete
  Future<void> deleteBookReaderInfo(BookReaderInfo bookReaderInfo);
}
