import 'package:flutter/cupertino.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_image.dart';
import 'package:voidlord/tono_reader/model/widget/tono_ruby.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/widget_provider/tono_widget_provider.dart';
import 'package:voidlord/tono_reader/render/tono_text_render.dart';
import 'package:voidlord/tono_reader/render/tono_ruby_render.dart';
import 'package:voidlord/tono_reader/render/tono_image_render.dart';
import 'package:voidlord/tono_reader/render/tono_container_render.dart';

class TonoRender {
  TonoRender({
    required this.widgetProvider,
  });

  final TonoWidgetProvider widgetProvider;

  Future<List<Widget>> rendeById(String id) async {
    var tonoWidgets = await widgetProvider.getWidgetsById(id);

    return Future.wait(tonoWidgets.map((x) async {
      if (x is TonoImage) {
        return await rendeImage(x, 18);
      }
      if (x is TonoText) {
        return rendeText(x, 18);
      }
      if (x is TonoRuby) {
        return rendeRuby(x, 18);
      }
      if (x is TonoContainer) {
        return rendeContainer(x, 18);
      }
      return Text("unkonwn widget");
    }).toList());
  }
}
