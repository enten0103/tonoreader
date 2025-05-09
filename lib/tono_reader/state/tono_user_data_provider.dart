import 'package:get/get.dart';
import 'package:voidlord/model/book_reader_info.dart';
import 'package:voidlord/model/dao/book_reader_info_dao.dart';
import 'package:voidlord/model/tono_book_mark.dart';
import 'package:voidlord/model/tono_book_note.dart';
import 'package:voidlord/repo/database.dart';
import 'package:voidlord/tono_reader/model/base/tono_location.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';

class TonoUserDataProvider extends GetxController {
  List<TonoBookMark> bookmarks = [];
  List<TonoBookNote> booknotes = [];
  var bookHash = Get.find<TonoProvider>().bookHash;
  TonoLocation histroy = TonoLocation(xhtmlIndex: 0, elementIndex: 0);
  BookReaderInfoDao bookInfoDao = Get.find<AppDatabase>().bookInfoDao;
  Future init() async {
    await initFromLocal();
  }

  Future initFromLocal() async {
    var bookReaderInfo = await bookInfoDao.findByBookHash(bookHash);
    if (bookReaderInfo != null) {
      var bookMarkList = bookReaderInfo.bookMarks;
      var noteList = bookReaderInfo.bookNotes;
      bookmarks.addAll(bookMarkList);
      booknotes.addAll(noteList);
      histroy = bookReaderInfo.histroy ??
          TonoLocation(xhtmlIndex: 0, elementIndex: 0);
    }
  }

  Future saveToLocal() async {
    var old = await bookInfoDao.findByBookHash(bookHash);
    var bookInfo = BookReaderInfo(
      bookHash: bookHash,
      bookMarks: bookmarks,
      bookNotes: booknotes,
    );
    if (old == null) {
      bookInfoDao.insertBookReaderInfo(bookInfo);
    } else {
      bookInfoDao.updateBookReaderInfo(bookInfo);
    }
  }

  bool isMarked(TonoLocation location) {
    return bookmarks.firstWhereOrNull((e) =>
                e.location.elementIndex == location.elementIndex &&
                e.location.xhtmlIndex == location.xhtmlIndex) !=
            null ||
        booknotes.firstWhereOrNull((e) =>
                e.location.elementIndex == location.elementIndex &&
                e.location.xhtmlIndex == location.elementIndex) !=
            null;
  }

  @override
  void onClose() => saveToLocal();
}
