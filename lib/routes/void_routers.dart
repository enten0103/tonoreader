import 'package:get/route_manager.dart';
import 'package:voidlord/bindings/book_detail_binding.dart';
import 'package:voidlord/bindings/index_binding.dart';
import 'package:voidlord/bindings/reader_binding.dart';
import 'package:voidlord/bindings/search_pre_binding.dart';
import 'package:voidlord/pages/detail/view.dart';
import 'package:voidlord/pages/index/view.dart';
import 'package:voidlord/pages/reader/view.dart';
import 'package:voidlord/pages/search_pre/view.dart';
import 'package:voidlord/pages/test/view.dart';

class VoidRouters {
  static const String testPage = "/test";
  static const String indexPage = "/index";
  static const String bookInfoPage = "/bookInfo";
  static const String searchPrePage = "/searchPre";
  static const String readerPage = "/reader";
  static final List<GetPage> getPages = [
    GetPage(
        name: indexPage,
        page: () => const IndexPage(),
        binding: IndexBinding()),
    GetPage(
        name: bookInfoPage,
        page: () => const BookDetailPage(),
        binding: BookDetailBinding()),
    GetPage(
        name: searchPrePage,
        page: () => const SearchPrePage(),
        binding: SearchPreBinding()),
    GetPage(
        name: readerPage,
        page: () => const ReaderPage(),
        binding: ReaderBinding()),
    GetPage(name: testPage, page: () => const TestPage())
  ];
}
