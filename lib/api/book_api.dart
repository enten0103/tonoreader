import 'package:voidlord/api/index.dart';
import 'package:voidlord/model/book_detail.dart';

extension BookApi on Api {
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
