import 'package:get/route_manager.dart';
import 'package:voidlord/bindings/book_detail_binding.dart';
import 'package:voidlord/bindings/index_binding.dart';
import 'package:voidlord/pages/book_detail/view.dart';
import 'package:voidlord/pages/index/view.dart';

class VoidRouters {
  static const String indexPage = "/index";
  static const String bookInfoPage = "/bookInfo";
  static final List<GetPage> getPages = [
    GetPage(
        name: indexPage,
        page: () => const IndexPage(),
        binding: IndexBinding()),
    GetPage(
        name: bookInfoPage,
        page: () => const BookDetailPage(),
        binding: BookDetailBinding())
  ];
}
