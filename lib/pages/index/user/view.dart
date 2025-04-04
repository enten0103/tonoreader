import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Text.rich(TextSpan(children: [
      TextSpan(
        text: "123322222",
        style: TextStyle(
          height: 1.5,
          fontSize: 18,
        ),
      ),
      WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: Container(
          width: 100,
          height: 27,
          color: Colors.tealAccent,
          child: ClipRect(
            child: Transform.translate(
                offset: Offset(0, -27),
                child: Text("1234562193912391293",
                    style: TextStyle(
                      overflow: TextOverflow.visible, // 允许内容溢出可见
                      height: 1.5,
                      fontSize: 18,
                    ))),
          ),
        ),
      )
    ]))));
  }
}
