import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:voidlord/api/book_api.dart';
import 'package:voidlord/api/index.dart';
import 'package:voidlord/model/book_detail.dart';
import 'package:voidlord/utils/type.dart';

class BookDetailController extends GetxController {
  var logger = Logger();
  late BookDetailModel bookDetailModel;
  Rx<LoadingState> loadingState = LoadingState.loading.obs;
  @override
  void onInit() async {
    try {
      var api = Get.find<Api>();
      await Future.delayed(Duration(seconds: 1));
      bookDetailModel = await api.getBookDetail(Get.arguments.id);
      loadingState.value = LoadingState.success;
    } catch (_) {
      loadingState.value = LoadingState.failed;
    }
    super.onInit();
  }
}
