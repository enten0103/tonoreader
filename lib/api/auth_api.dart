import 'package:voidlord/api/index.dart';
import 'package:voidlord/exception/auth_exception.dart';
import 'package:voidlord/model/dto/auth_dto.dart';

extension AuthApi on Api {
  Future<AuthResponse> register(
      String username, String email, String password) async {
    final response = await client.post("/auth/register", data: {
      "username": username,
      "email": email,
      "password": password,
    });
    // 新接口：201 创建成功；冲突 409
    if (response.statusCode == 201) {
      // 返回 LoginResponseDto: { access_token, user: { id, username, email, ... } }
      return AuthResponse.fromLoginResponse(response.data);
    }
    if (response.statusCode == 409) {
      throw UserNameHasBeanUsedException();
    }
    throw Exception('Failed to register');
  }

  Future<LoginResponseData> login(String username, String password) async {
    final response = await client.post("/auth/login", data: {
      "username": username,
      "password": password,
    });
    // 新接口：201 登录成功；401 失败
    if (response.statusCode == 201) {
      return LoginResponseData.fromJson(response.data as Map<String, dynamic>);
    }
    throw Exception('账号或密码错误');
  }
}
