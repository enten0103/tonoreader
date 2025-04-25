import 'package:flutter/cupertino.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/render/state/tono_inline_state_provider.dart';
import 'package:voidlord/tono_reader/render/widget/tono_container_widget.dart';
import 'package:voidlord/tono_reader/render/widget/tono_inline_container_widget.dart';
import 'package:voidlord/tono_reader/render/widget/tono_ruby_widget.dart';

extension TonoContainerTool on TonoContainer {
  List<Widget> genChildren() {
    List<Widget> children = [];
    List<TonoWidget> inlineChildren = [];
    for (var child in this.children) {
      if (child is TonoRuby) {
        if (inlineChildren.isNotEmpty) {
          children.add(TonoInlineStateProvider(
              state: InlineState(),
              child: TonoInlineContainerWidget(
                inlineWidgets: [...inlineChildren],
              )));
          inlineChildren.clear();
        }
        children.add(TonoRubyWidget(tonoRuby: child));
      } else if (child is TonoContainer) {
        if (child.display == "inline") {
          inlineChildren.add(child);
        } else {
          if (inlineChildren.isNotEmpty) {
            children.add(TonoInlineStateProvider(
                state: InlineState(),
                child: TonoInlineContainerWidget(
                  inlineWidgets: [...inlineChildren],
                )));
            inlineChildren.clear();
          }
          children.add(TonoContainerWidget(
            key: Key("${child.className}@${child.hashCode}"),
            tonoContainer: child,
          ));
        }
      } else {
        inlineChildren.add(child);
      }
    }

    if (inlineChildren.isNotEmpty) {
      children.add(TonoInlineStateProvider(
          state: InlineState(),
          child: TonoInlineContainerWidget(
            inlineWidgets: inlineChildren,
          )));
    }
    return children;
  }
}
