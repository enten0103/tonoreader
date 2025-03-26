import 'package:voidlord/tono_reader/model/base/tono_book_info.dart';
import 'package:voidlord/tono_reader/widget_provider/tono_widget_provider.dart';

///Tono文件模型
class Tono {
  const Tono(
      {required this.bookInfo,
      required this.fontPrefix,
      required this.navItems,
      required this.xhtmls,
      required this.widgetProvider});

  final String fontPrefix;

  ///基础信息
  final TonoBookInfo bookInfo;

  ///导航信息
  final List<TonoNavItem> navItems;

  ///xhtml序列
  final List<String> xhtmls;

  ///布局信息提供器
  final TonoWidgetProvider widgetProvider;
}
