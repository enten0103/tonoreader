import 'package:voidlord/api/index.dart';
import 'package:voidlord/pages/index/home/module.dart';

extension HomePageApi on Api {
  Future<List<BookBlockModule>> getIndexBlocks() async {
    final response = await client.get("/home/blocks");
    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.data["data"];
      var r = jsonList.map((json) => BookBlockModule.fromJson(json));
      return r.toList();
    } else {
      throw Exception('Failed to load index blocks');
    }
  }
}
