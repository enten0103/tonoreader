import 'dart:typed_data';

import 'package:dio/dio.dart' show FormData, MultipartFile, Options;
import 'package:voidlord/api/index.dart';
import 'package:voidlord/model/book_detail.dart';
import 'package:voidlord/model/book_upload.dart';

extension BookApi on Api {
  Future<String> uploadPart(String bookId, String fileName, Uint8List file,
      String contentType, String part) async {
    final response = await client.post("/upload/$bookId/$part",
        data: FormData.fromMap({
          "file": MultipartFile.fromBytes(
            file,
            filename: fileName,
          ),
          "name": fileName,
        }),
        options: Options(contentType: 'application/form-data'));
    if (response.statusCode == 200) {
      return response.data["data"]['url'];
    } else {
      throw Exception('Failed to upload book');
    }
  }

  Future<BookUploadModule> createUpload(String title, String bookhash) async {
    final response = await client.post("/upload/create", data: {
      "title": title,
      "bookhash": bookhash,
    });
    if (response.statusCode == 200) {
      return BookUploadModule.fromJson(response.data["data"]);
    } else {
      throw Exception('Failed to create upload');
    }
  }

  Future<List<BookUploadModule>> listUpload() async {
    final response = await client.get("/upload/list");
    if (response.statusCode == 200) {
      List<dynamic> data = response.data["data"];
      return data
          .map(
              (json) => BookUploadModule.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load upload list');
    }
  }

  Future<BookDetailModel> getBookDetail(String bookId) async {
    final response = await client.get("/book/detail/$bookId");
    if (response.statusCode == 200) {
      dynamic data = response.data["data"];
      return BookDetailModel.fromMap(data);
    } else {
      throw Exception('Failed to ger book detail');
    }
  }
}
