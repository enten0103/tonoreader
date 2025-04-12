import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyWidget has a title and message', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            body: Container(
          width: 10,
          height: 20,
          color: Colors.greenAccent,
          child: Text("123"),
        ))));
  });
}
