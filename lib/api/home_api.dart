import 'package:voidlord/api/index.dart';
import 'package:voidlord/model/book_block.dart';

extension HomePageApi on Api {
  Future<List<BookBlockModel>> getIndexBlocks() async {
    final response = await client.get("/home/blocks");
    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data["data"];
      return jsonList.map((json) => BookBlockModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load index blocks');
    }
  }
}
