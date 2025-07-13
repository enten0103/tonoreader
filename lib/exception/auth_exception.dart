class UserNameHasBeanUsedException implements Exception {
  final String message;

  UserNameHasBeanUsedException(
      [this.message = 'Username has already been used.']);

  @override
  String toString() {
    return 'UserNameHasBeanUsedException: $message';
  }
}
