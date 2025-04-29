import 'dart:convert';

class TonoLocation {
  TonoLocation({
    required this.xhtmlIndex,
    required this.elementIndex,
  });
  int xhtmlIndex;
  int elementIndex;

  Map<String, dynamic> toMap() {
    return {
      "xhtmlIndex": xhtmlIndex,
      "elementIndex": elementIndex,
    };
  }

  static TonoLocation fromMap(Map<String, dynamic> map) {
    return TonoLocation(
      xhtmlIndex: map['xhtmlIndex'] as int,
      elementIndex: map['elementIndex'] as int,
    );
  }

  @override
  String toString() {
    return json.encoder.convert(toMap());
  }
}
