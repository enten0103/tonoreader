class TonoNavpoint {
  const TonoNavpoint({
    required this.id,
    required this.index,
  });
  final String id;
  final int index;
  @override
  String toString() {
    return "$id:$index";
  }
}
