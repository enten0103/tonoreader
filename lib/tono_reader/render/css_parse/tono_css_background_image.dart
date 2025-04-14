import 'package:path/path.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';

extension TonoCssBackgroundImage on FlutterStyleFromCss {
  String? get backgroundImage => _parseBackgroundImage();

  String? _parseBackgroundImage() {
    var cssBackgroundImage = css['background-image'] ?? css['background'];
    if (cssBackgroundImage == null) return null;
    final regex = RegExp(r'''url\(["\']?(.*?)["\']?\)''');
    var url = regex.firstMatch(cssBackgroundImage)?.group(1);
    if (url == null) return null;
    return basenameWithoutExtension(url);
  }
}
