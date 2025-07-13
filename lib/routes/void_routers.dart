import 'package:get/route_manager.dart';
import 'package:voidlord/bindings/book_detail_binding.dart';
import 'package:voidlord/bindings/book_upload_detail_binding.dart';
import 'package:voidlord/bindings/index_binding.dart';
import 'package:voidlord/bindings/login_binding.dart';
import 'package:voidlord/bindings/reader_binding.dart';
import 'package:voidlord/bindings/register_binding.dart';
import 'package:voidlord/bindings/search_pre_binding.dart';
import 'package:voidlord/bindings/upload_binding.dart';
import 'package:voidlord/pages/auth/register/view.dart';
import 'package:voidlord/pages/detail/view.dart';
import 'package:voidlord/pages/index/view.dart';
import 'package:voidlord/pages/auth/login/view.dart';
import 'package:voidlord/pages/reader/view.dart';
import 'package:voidlord/pages/search_pre/view.dart';
import 'package:voidlord/pages/test/view.dart';
import 'package:voidlord/pages/upload/detail/view.dart';
import 'package:voidlord/pages/upload/view.dart';

class VoidRouters {
  static const String testPage = "/test";
  static const String indexPage = "/index";
  static const String bookInfoPage = "/bookInfo";
  static const String searchPrePage = "/searchPre";
  static const String readerPage = "/reader";
  static const String uploadPage = "/upload";
  static const String loginPage = "/login";
  static const String registerPage = "/register";
  static const String bookUploadDetailPage = "/bookUploadDetail";

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
    GetPage(name: testPage, page: () => const TestPage()),
    GetPage(
        name: uploadPage,
        page: () => const UploadPage(),
        binding: UploadBinding()),
    GetPage(
        name: loginPage,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: registerPage,
        page: () => const RegisterPage(),
        binding: RegisterBinding()),
    GetPage(
        name: bookUploadDetailPage,
        page: () => const UploadDetailPage(),
        binding: BookUploadDetailBinding()),
  ];
}
