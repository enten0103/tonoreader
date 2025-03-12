import 'package:voidlord/tono_reader/model/style/tono_style.dart';

extension CssTool on List<TonoStyle> {
  Map<String, String> toMap() {
    Map<String, String> result = {};
    forEach((e) {
      result[e.property] = e.value;
    });
    return result;
  }
}
