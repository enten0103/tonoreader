import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/render/widget/tono_container_widget.dart';
import 'package:voidlord/tono_reader/render/widget/tono_inline_container_widget.dart';
import 'package:voidlord/tono_reader/render/widget/tono_ruby_widget.dart';
import 'package:voidlord/tono_reader/state/tono_flager.dart';

class TonoContainerState extends GetxController {
  late TonoWidget container;
  List<Widget> updateContainer(
    int pageIndex,
    TonoContainer tonoContainer, {
    bool indented = false,
  }) {
    var flager = Get.find<TonoFlager>();
    container = tonoContainer;
    List<Widget> children = [];
    List<TonoWidget> inlineChildren = [];
    if (tonoContainer.children != null) {
      for (var child in tonoContainer.children!) {
        if (flager.paging.value &&
            container.className == "body" &&
            child.extra['height'] != null) {
          continue;
        }
        if (!flager.paging.value) {
          if (child.extra['pageIndex'] != null &&
              !(child.extra['pageIndex'] as List).contains(pageIndex) &&
              container.className == "body") {
            continue;
          }
        }
        if (child is TonoRuby) {
          if (inlineChildren.isNotEmpty) {
            children.add(TonoInlineContainerWidget(
              inlineWidgets: [...inlineChildren],
              pageIndex: pageIndex,
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
                pageIndex: pageIndex,
                inlineWidgets: [...inlineChildren],
                indented: indented,
              ));
              inlineChildren.clear();
            }
            children.add(TonoContainerWidget(
              key: Key(
                  "height:${child.extra['totalHeight']} currentHeight:${child.extra['currentHeight']} margin:${child.extra['margin']} @${child.hashCode}"),
              tonoContainer: child,
              pageIndex: pageIndex,
            ));
          }
        } else {
          inlineChildren.add(child);
        }
      }
    }

    if (inlineChildren.isNotEmpty) {
      children.add(TonoInlineContainerWidget(
        pageIndex: pageIndex,
        inlineWidgets: inlineChildren,
        indented: indented,
      ));
    }
    return children;
  }
}
