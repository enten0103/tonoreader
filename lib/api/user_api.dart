import 'package:voidlord/api/index.dart';
import 'package:voidlord/model/dto/user_dto.dart';

extension UserApi on Api {
  Future<List<User>> listUsers() async {
    final resp = await client.get('/users');
    if (resp.statusCode == 200) {
      final data = resp.data;
      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map(User.fromJson)
            .toList();
      }
      // 兼容包装结构 { users: [...] }
      if (data is Map && data['users'] is List) {
        return (data['users'] as List)
            .whereType<Map<String, dynamic>>()
            .map(User.fromJson)
            .toList();
      }
      return <User>[];
    }
    throw Exception('Failed to load users: ${resp.statusCode}');
  }
}
