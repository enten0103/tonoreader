import 'package:flutter/widgets.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_provider.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_align_item.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_display.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_justify_content.dart';
import 'package:voidlord/tono_reader/tool/reversed_column.dart';

/// 实现如下CSS
/// - display
/// - justify-content
/// - align-item
/// - text-align
class TonoCssDisplayWidget extends StatelessWidget {
  const TonoCssDisplayWidget({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    var tonoContainer = context.tonoWidget;
    var fci = tonoContainer.css.convert();
    var display = fci.display;
    var justifyContent = fci.justifyContent;
    var alignItem = fci.alignItems;
    return switch (display) {
      CssDisplay.flex => Row(
          mainAxisAlignment: justifyContent,
          crossAxisAlignment: alignItem,
          children: children,
        ),
      CssDisplay.block => ReversedColumn(
          crossAxisAlignment: alignItem,
          mainAxisAlignment: justifyContent,
          children: children,
        )
    };
  }
}
