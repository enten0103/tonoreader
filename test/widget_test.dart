import 'package:flutter_test/flutter_test.dart';
import 'package:html/parser.dart';

void main() {
  test('self close html tag parer test', () {
    var html = '''
  <html>
    <body>
      <div>1</div>
      <div />
      <div>2</div>
    </body>
  </html>
''';
    var document = parse(html);
    var childlength = document.body?.children.length;
    expect(childlength, 3);
  });
}
