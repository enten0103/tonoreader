class AuthRequest {
  final String username;
  final String password;

  const AuthRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  static AuthRequest fromJson(Map<String, dynamic> json) {
    return AuthRequest(
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }
}

class AuthResponse {
  final String id;
  final String username;

  const AuthResponse({
    required this.id,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }

  static AuthResponse fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      id: json['id'] as String,
      username: json['username'] as String,
    );
  }

  /// 兼容新后端登录/注册返回结构：
  /// {
  ///   "access_token": "...",
  ///   "user": { "id": 1, "username": "john_doe", ... }
  /// }
  static AuthResponse fromLoginResponse(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;
    if (user == null) {
      throw ArgumentError('Invalid login response: missing user');
    }
    return AuthResponse(
      id: '${user['id']}',
      username: user['username'] as String,
    );
  }
}

class LoginResponseData {
  final String accessToken;
  final LoginUser user;

  LoginResponseData({required this.accessToken, required this.user});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      accessToken: json['access_token'] as String,
      user: LoginUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class LoginUser {
  final int id;
  final String username;
  final String? email;

  LoginUser({required this.id, required this.username, this.email});

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String?,
    );
  }
}
