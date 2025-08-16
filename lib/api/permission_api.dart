import 'package:voidlord/api/index.dart';
import 'package:voidlord/model/dto/permission_dto.dart';

extension PermissionApi on Api {
  /// 获取用户权限列表：GET /permissions/user/{id}
  Future<List<UserPermission>> getUserPermissions(int userId) async {
    final resp = await client.get('/permissions/user/$userId');
    if (resp.statusCode == 200) {
      final data = resp.data;
      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map(UserPermission.fromJson)
            .toList();
      }
      // 兼容可能返回 { permissions: [...] }
      if (data is Map && data['permissions'] is List) {
        return (data['permissions'] as List)
            .whereType<Map<String, dynamic>>()
            .map(UserPermission.fromJson)
            .toList();
      }
      return [];
    }
    throw Exception('Failed to load permissions');
  }
}
