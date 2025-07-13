import 'package:voidlord/api/index.dart';
import 'package:voidlord/exception/auth_exception.dart';
import 'package:voidlord/model/dto/auth_dto.dart';

extension AuthApi on Api {
  Future<AuthResponse> register(String username, String password) async {
    final response = await client.post("/register", data: {
      "username": username,
      "password": password,
    });
    if (response.statusCode != 200) {
      if (response.data['code'] == 1001) {
        throw UserNameHasBeanUsedException();
      }
      throw Exception('Failed to register');
    }
    return AuthResponse.fromJson(response.data['data']);
  }

  Future<String> login(String username, String password) async {
    final response = await client.post("/login", data: {
      "username": username,
      "password": password,
    });
    if (response.statusCode != 200) {
      throw Exception('账号或密码错误');
    }
    return response.data['data'] as String;
  }
}
