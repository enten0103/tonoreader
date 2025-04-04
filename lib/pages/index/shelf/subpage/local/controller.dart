import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/state_manager.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:voidlord/model/book_reader.dart';
import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/tono_reader/tool/tono_serializer.dart';

class LocalShelfPageController extends GetxController {
  RxList<BookReaderModel> bookLocalModels = <BookReaderModel>[].obs;

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
    var parser = await TonoParser.initFormDisk(file!.path!);
    var tono = await parser.parse();
    await TonoSerializer.save(tono);
    await init();
  }

  init() async {
    bookLocalModels.clear();
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
          bookLocalModels
              .add(BookReaderModel(id: id, title: title, coverUrl: cover));
        }
      }
    }
  }

  @override
  void onInit() async {
    init();
    super.onInit();
  }
}
