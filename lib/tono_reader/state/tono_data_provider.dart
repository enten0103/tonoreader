import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/model/base/tono_book_info.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';
import 'package:voidlord/tono_reader/state/tono_progresser.dart';

class TonoProvider extends GetxController {
  late Tono tono;
  String fontPrefix = "";
  String title = "";
  List<TonoNavItem> navList = [];
  List<TonoWidget> widgets = [];
  List<String> xhtmls = [];

  void initSliderProgressor() {
    var progressor = Get.find<TonoProgresser>();
    int sum = 0;
    for (int i = 0; i < widgets.length; i++) {
      var w = widgets[i];
      if (w is TonoContainer) {
        var elementCount = (w.children[0] as TonoContainer).children.length;
        progressor.elementSequence.add(elementCount);
        sum += elementCount;
      }
    }
    progressor.totalElementCount = sum;
  }

  bool isLast(int count) {
    var progressor = Get.find<TonoProgresser>();
    int index = 0;
    while (count - progressor.elementSequence[index] >= 0 &&
        index < progressor.elementSequence.length) {
      count -= progressor.elementSequence[index];
      index++;
    }
    return (((widgets[index] as TonoContainer).children[0]) as TonoContainer)
            .children
            .length ==
        count + 1;
  }

  TonoWidget getWidgetByElementCount(int count) {
    var progressor = Get.find<TonoProgresser>();
    int index = 0;
    while (count - progressor.elementSequence[index] >= 0 &&
        index < progressor.elementSequence.length) {
      count -= progressor.elementSequence[index];
      index++;
    }
    return (((widgets[index] as TonoContainer).children[0]) as TonoContainer)
        .children[count] as TonoContainer;
  }

  Future init(Tono tono) async {
    this.tono = tono;
    fontPrefix = tono.hash;
    title = tono.bookInfo.title;
    navList.addAll(List.from(tono.navItems));
    xhtmls.addAll(List.from(tono.xhtmls));
    for (var i = 0; i < xhtmls.length; i++) {
      var id = xhtmls[i];
      widgets.add(await getWidgetById(id));
    }
  }

  Future<TonoWidget> getWidgetById(String id) async {
    return tono.widgetProvider.getWidgetsById(id);
  }
}
