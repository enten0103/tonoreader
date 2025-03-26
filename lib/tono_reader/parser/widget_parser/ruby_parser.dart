import 'package:html/dom.dart';
import 'package:voidlord/tono_reader/model/parser/tono_style_sheet_block.dart';
import 'package:voidlord/tono_reader/model/style/tono_style.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/tono_reader/parser/tono_selector_macher.dart';

extension RubyParser on TonoParser {
  TonoWidget toRuby(
    Element element,
    List<TonoStyleSheetBlock> css, {
    List<TonoStyle>? inheritStyles,
  }) {
    var matchedCss = matchAll(element, css, inheritStyles);
    var textNodes = element.nodes.where((e) => e.parentNode == element);
    try {
      List<RubyItem> texts = [];
      for (var e in textNodes) {
        if (e.nodeType == 3) {
          texts.add(RubyItem(text: e.text!));
        } else {
          var ruby = e.nodes
              .where((x) => x.parentNode == e)
              .where((x) => x.nodeType != 1 || (x as Element).localName == "rt")
              .where((x) => x.nodeType != 3 || x.text?.trim() != "")
              .toList();
          for (var i = 0; i < ruby.length; i += 2) {
            texts.add(RubyItem(
                text: ruby[i].text!.trim(), ruby: ruby[i + 1].text?.trim()));
          }
        }
      }
      return TonoRuby(texts: texts, css: matchedCss);
    } catch (_) {
      List<RubyItem> texts = [];
      try {
        for (var e in textNodes) {
          if (e.nodeType == 3) {
            texts.add(RubyItem(text: e.text!));
          } else {
            var ruby = e as Element;
            var rbs = ruby.getElementsByTagName('rb');
            var rts = ruby.getElementsByTagName('rt');
            for (var i = 0; i < rbs.length; i++) {
              texts.add(
                  RubyItem(text: rbs[i].text.trim(), ruby: rts[i].text.trim()));
            }
          }
        }
        return TonoRuby(texts: texts, css: matchedCss);
      } catch (_) {
        return TonoRuby(texts: [], css: matchedCss);
      }
    }
  }
}
