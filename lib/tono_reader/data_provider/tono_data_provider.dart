import 'dart:typed_data';

abstract class TonoDataProvider {
  ///获取opf文件路径
  Future<String> getOpf();

  Future<String> getContainer();

  ///通过path获取文件
  Future<Uint8List?> getFileByPath(String path);

  String get hash;
}
