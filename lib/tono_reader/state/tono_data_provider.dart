import 'package:get/state_manager.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/model/base/tono_book_info.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class TonoProvider extends GetxController {
  late Tono tono;
  String fontPrefix = "";
  String title = "";
  List<TonoNavItem> navList = [];
  List<TonoWidget> widgets = [];
  List<String> xhtmls = [];
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
