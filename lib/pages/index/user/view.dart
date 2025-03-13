import 'package:flutter/material.dart';
import 'package:ruby_text/ruby_text.dart';
import 'package:voidlord/tono_reader/tool/margin.dart';
import 'package:voidlord/tono_reader/tool/reversed_column.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReversedColumn(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: "111",
                style: TextStyle(textBaseline: TextBaseline.alphabetic)),
            WidgetSpan(
                baseline: TextBaseline.alphabetic,
                alignment: PlaceholderAlignment.baseline,
                child: Stack(
                  children: [
                    Text("11"),
                    Positioned(bottom: 10, child: Text("22"))
                  ],
                )),
            WidgetSpan(
                baseline: TextBaseline.alphabetic,
                alignment: PlaceholderAlignment.baseline,
                child: AdaptiveMargin(
                    margin: EdgeInsets.only(left: -10),
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Text("112"),
                    ))),
            TextSpan(text: "222"),
          ])),
        ),
      ],
    );
  }
}
