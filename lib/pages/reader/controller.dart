import 'package:get/get.dart';

class ReaderController extends GetxController {
  late RxString path = Get.parameters["path"]!.obs;
  late RxString type = Get.parameters["type"]!.obs;
}
