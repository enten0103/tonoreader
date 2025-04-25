import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/tool/styled_border.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    var scale = 1.1.obs;
    return SafeArea(
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: StyledBorder(
                        top: StyledBorderSide(color: Colors.red),
                        right: StyledBorderSide(color: Colors.green),
                        left: StyledBorderSide(color: Colors.yellow),
                        bottom: StyledBorderSide(color: Colors.blue))),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Obx(
                    () => AnimatedScale(
                        scale: scale.value,
                        duration: Duration(milliseconds: 500),
                        child: ElevatedButton(
                            onPressed: () {
                              scale.value += 1;
                            },
                            child: ScrollablePositionedList.builder(
                                itemCount: 100,
                                itemBuilder: (_, index) {
                                  print(index);
                                  return Text("1234567890$index");
                                }))),
                  ),
                ))));
  }
}

class TestWidget5 extends StatelessWidget {
  const TestWidget5({super.key});
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class TestWidget4 extends StatelessWidget {
  const TestWidget4({super.key});
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

/// sized padding widget test
class TestWidget1 extends StatelessWidget {
  const TestWidget1({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text("123"),
    );
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
