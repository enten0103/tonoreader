import 'dart:typed_data';

abstract class TonoDataProvider {
  ///获取opf文件路径
  Future<String> getOpf();

  ///通过path获取文件
  Future<Uint8List?> getFileByPath(String path);
}
