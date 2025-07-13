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
}
