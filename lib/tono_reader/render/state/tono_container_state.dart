import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/render/widget/tono_container_widget.dart';
import 'package:voidlord/tono_reader/render/widget/tono_inline_container_widget.dart';
import 'package:voidlord/tono_reader/render/widget/tono_ruby_widget.dart';

class TonoContainerState extends GetxController {
  late TonoWidget container;
  List<Widget> updateContainer(
    TonoContainer tonoContainer, {
    bool indented = false,
  }) {
    container = tonoContainer;
    List<Widget> children = [];
    List<TonoWidget> inlineChildren = [];
    if (tonoContainer.children != null) {
      for (var child in tonoContainer.children!) {
        if (child is TonoRuby) {
          if (inlineChildren.isNotEmpty) {
            children.add(TonoInlineContainerWidget(
              inlineWidgets: [...inlineChildren],
              indented: indented,
            ));
            inlineChildren.clear();
          }
          children.add(TonoRubyWidget(tonoRuby: child));
        } else if (child is TonoContainer) {
          if (child.display == "inline") {
            inlineChildren.add(child);
          } else {
            if (inlineChildren.isNotEmpty) {
              children.add(TonoInlineContainerWidget(
                inlineWidgets: [...inlineChildren],
                indented: indented,
              ));
              inlineChildren.clear();
            }
            children.add(TonoContainerWidget(
              tonoContainer: child,
            ));
          }
        } else {
          inlineChildren.add(child);
        }
      }
    }

    if (inlineChildren.isNotEmpty) {
      children.add(TonoInlineContainerWidget(
        inlineWidgets: inlineChildren,
        indented: indented,
      ));
    }
    return children;
  }
}
