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

  /// 授予权限：POST /permissions/grant
  Future<void> grantPermission({
    required int userId,
    required String permission,
    required int level,
  }) async {
    final resp = await client.post('/permissions/grant', data: {
      'userId': userId,
      'permission': permission,
      'level': level,
    });
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Grant failed: ${resp.statusCode}');
    }
  }

  /// 撤销权限：POST /permissions/revoke
  Future<void> revokePermission({
    required int userId,
    required String permission,
  }) async {
    final resp = await client.post('/permissions/revoke', data: {
      'userId': userId,
      'permission': permission,
    });
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Revoke failed: ${resp.statusCode}');
    }
  }
}
