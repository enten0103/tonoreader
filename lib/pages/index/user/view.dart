import 'package:flutter/material.dart';
import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_provider.dart';
import 'package:voidlord/tono_reader/render/tono_css/tono_css_size_padding_widget.dart';
import 'package:voidlord/tono_reader/tool/span_table.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 600,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.blue,
            width: 1,
          )),
          child: SpanTable(data: [
            [
              SpanCell(child: Text("Person")),
              SpanCell(child: Text("Most interest in")),
              SpanCell(child: Text("Age")),
            ],
            [
              SpanCell(rowSpan: 2, child: Text("Chris")),
              SpanCell(child: Text("22")),
            ],
            [
              SpanCell(child: Text("Sarah")),
              SpanCell(child: Text("JavaScript frameworks")),
              SpanCell(child: Text("29")),
            ],
            [
              SpanCell(
                colSpan: 2,
                child: Text(
                  "123",
                  textAlign: TextAlign.center,
                ),
              ),
              SpanCell(child: Text("33")),
            ]
          ]),
        ),
      ),
    );
  }
}

/// sized padding widget test
class TestWidget1 extends StatelessWidget {
  const TestWidget1({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child: Container(
      width: 300,
      height: 300,
      color: Colors.blue,
      child: Column(children: [
        TonoContainerProvider(
            data: TestTonoContainer.tonoWidget1(),
            child: TonoCssSizePaddingWidget(
                child: Column(
              children: [
                TonoContainerProvider(
                    data: TestTonoContainer.tonoWidget2(),
                    child: TonoCssSizePaddingWidget(child: Text("123")))
              ],
            ))),
      ]),
    )));
  }
}

class TestTonoContainer {
  static TonoWidget tonoWidget1() {
    return TonoContainer(
        className: "div",
        css: [
          TonoStyle(priority: 0, value: "18px", property: "font-size"),
          TonoStyle(priority: 0, value: "40px", property: "height"),
        ],
        display: 'block',
        children: [
          TonoText(
            text: "12345",
            css: [
              TonoStyle(priority: 0, value: "18px", property: "font-size"),
            ],
          )
        ]);
  }

  static TonoWidget tonoWidget2() {
    return TonoContainer(
        className: "p",
        css: [
          TonoStyle(priority: 0, value: "18px", property: "font-size"),
          TonoStyle(priority: 0, value: "20px", property: "height"),
          TonoStyle(priority: 0, value: "fit-content", property: "width")
        ],
        display: 'block',
        children: [
          TonoText(
            text: "12345",
            css: [
              TonoStyle(priority: 0, value: "18px", property: "font-size"),
            ],
          )
        ]);
  }
}
