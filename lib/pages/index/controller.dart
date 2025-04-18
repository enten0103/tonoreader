import 'package:get/get.dart';
import 'package:voidlord/pages/index/home/view.dart';
import 'package:voidlord/pages/index/shelf/view.dart';
import 'package:voidlord/pages/index/user/view.dart';

class IndexController extends GetxController {
  var selectIndex = 0.obs;
  var pages = [HomePage(), ShelfPage(), UserPage()];
}
