import 'package:voidlord/tono_reader/model/base/tono_book_info.dart';
import 'package:voidlord/tono_reader/render/tono_render.dart';
import 'package:voidlord/tono_reader/widget_provider/tono_widget_provider.dart';

///Tono文件模型
class Tono {
  const Tono(
      {required this.bookInfo,
      required this.navItems,
      required this.widgetProvider});

  ///info.json
  ///基础信息
  final TonoBookInfo bookInfo;

  ///nav.json
  ///导航信息
  final List<TonoNavItem> navItems;

  ///布局信息提供器
  final TonoWidgetProvider widgetProvider;

  ///获取渲染器
  TonoRender genRender() {
    return TonoRender(widgetProvider: widgetProvider);
  }
}
