import 'package:get/state_manager.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/model/base/tono_book_info.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class TonoProvider extends GetxController {
  late Tono tono;
  String fontPrefix = "";
  String title = "";
  List<TonoNavItem> navList = [];
  List<String> xhtmls = [];
  void init(Tono tono) {
    this.tono = tono;
    fontPrefix = tono.fontPrefix;
    title = tono.bookInfo.title;
    navList.addAll(List.from(tono.navItems));
    xhtmls.addAll(List.from(tono.xhtmls));
  }

  Future<TonoWidget> getWidgetById(String id) async {
    return tono.widgetProvider.getWidgetsById(id);
  }
}
