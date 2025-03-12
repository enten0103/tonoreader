class BookLoadException implements Exception {
  final String message;
  BookLoadException(this.message);
  @override
  String toString() {
    return message;
  }
}
