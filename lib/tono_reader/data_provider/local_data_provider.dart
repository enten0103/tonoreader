import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voidlord/tono_reader/data_provider/tono_data_provider.dart';

class LocalDataProvider extends TonoDataProvider {
  LocalDataProvider({
    required this.root,
  });
  final String root;
  final Map<String, Uint8List> _fileMap = {};
  Future init() async {
    await loadFile(root);
  }

  @override
  Future<String> getOpf() async {
    return "OEBPS/content.opf";
  }

  @override
  Future<Uint8List?> getFileByPath(String path) async {
    return _fileMap[path];
  }

  Future loadFile(String filePath) async {
    final bytes = File(filePath).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    var baseUrl = "${(await getApplicationDocumentsDirectory()).path}/local";
    var hash = md5.convert(bytes).toString();
    var fileDirPath = '$baseUrl/$hash';
    var fileDir = Directory(fileDirPath);
    if (await fileDir.exists()) {
      await fileDir.delete(recursive: true);
    }
    for (final entry in archive) {
      if (entry.isFile) {
        _fileMap[entry.name] = entry.readBytes()!;
      }
    }
  }
}
