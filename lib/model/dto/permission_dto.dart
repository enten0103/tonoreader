class UserPermission {
  final String permission; // e.g., USER_READ
  final int level; // 0..3

  UserPermission({required this.permission, required this.level});

  factory UserPermission.fromJson(Map<String, dynamic> json) {
    return UserPermission(
      permission: json['permission'] as String,
      level: (json['level'] as num?)?.toInt() ?? 0,
    );
  }
}
