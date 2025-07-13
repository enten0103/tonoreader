import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:voidlord/model/book_reader.dart';
import 'package:voidlord/pages/index/components/parse_book_dialog.dart';
import 'package:voidlord/utils/list_tool.dart';

class LocalShelfPageController extends GetxController {
  RxList<BookReaderModel> bookLocalModels = <BookReaderModel>[].obs;
  RxInt current = 0.obs;
  RxInt total = 0.obs;
  RxString info = "".obs;

  void delete(String id) async {
    var baseDir = await getApplicationDocumentsDirectory();
    var bookDir = Directory(p.join(baseDir.path, "book", id));
    if (await bookDir.exists()) {
      bookDir.delete(recursive: true);
    }
    bookLocalModels.removeWhere((e) {
      return e.id == id;
    });
  }

  void addFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ["epub"]);
    var file = result?.files.first;
    await Get.dialog(ParseBookDialog(filePath: file!.path!));
    await init();
  }

  init() async {
    var nm = <BookReaderModel>[];
    var baseDir = await getApplicationDocumentsDirectory();
    var bookDir = Directory(p.join(baseDir.path, "book"));
    if (await baseDir.exists()) {
      var books = bookDir.listSync();
      for (var book in books) {
        var baseInfoFile = File(p.join(book.path, "info.json"));
        if (await baseInfoFile.exists()) {
          var baseInfo = json.decode(await baseInfoFile.readAsString())
              as Map<String, dynamic>;
          String id = p.basenameWithoutExtension(book.path);
          String title = baseInfo['title']!;
          String cover =
              p.join(book.path, 'assets', 'image', baseInfo['coverUrl']!);
          nm.add(BookReaderModel(id: id, title: title, coverUrl: cover));
        }
      }
    }
    mergeListsCustom<BookReaderModel>(bookLocalModels, nm, (a, b) {
      return a.id == b.id;
    });
  }

  @override
  void onInit() async {
    init();
    super.onInit();
  }
}
