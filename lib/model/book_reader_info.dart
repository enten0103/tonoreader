import 'package:floor/floor.dart';
import 'package:voidlord/repo/converter.dart';
import 'package:voidlord/model/tono_book_mark.dart';
import 'package:voidlord/model/tono_book_note.dart';
import 'package:voidlord/tono_reader/model/base/tono_location.dart';

@entity
@TypeConverters([
  BookNoteConverter,
  BookMarkConverter,
  BookLocationConverter,
])
class BookReaderInfo {
  @PrimaryKey()
  final String bookHash;

  TonoLocation? histroy;
  List<TonoBookMark> bookMarks;
  List<TonoBookNote> bookNotes;

  BookReaderInfo({
    required this.bookHash,
    this.histroy,
    required this.bookMarks,
    required this.bookNotes,
  });
}
