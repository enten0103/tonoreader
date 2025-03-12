import 'package:get/get.dart';
import 'package:voidlord/api/home_api.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/model/book_block.dart';
import 'package:voidlord/utils/type.dart';

class HomeController extends GetxController {
  List<BookBlockModel> bookBlocks = <BookBlockModel>[];
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  @override
  void onInit() async {
    super.onInit();
    try {
      var api = Get.find<Api>();
      var result = await api.getIndexBlocks();
      bookBlocks.addAll(result);
      loadingState.value = LoadingState.success;
    } catch (e) {
      loadingState.value = LoadingState.failed;
    }
  }
}
