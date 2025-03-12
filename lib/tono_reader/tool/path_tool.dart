import 'package:path/path.dart' as path;

extension PathTool on String {
  String pathSplicing(String relativePath) {
    var currentDir = path.dirname(this);
    while (relativePath.startsWith("../")) {
      relativePath = relativePath.replaceFirst("../", "");
      currentDir = path.dirname(currentDir);
    }
    return path.join(currentDir, relativePath);
  }
}
