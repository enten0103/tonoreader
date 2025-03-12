class TonoBookInfo {
  const TonoBookInfo({
    required this.title,
    required this.coverUrl,
  });

  final String title;
  final String coverUrl;
}

class TonoNavItem {
  const TonoNavItem({
    required this.path,
    required this.title,
  });
  final String path;
  final String title;
}
