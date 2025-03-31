import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:voidlord/utils/type.dart';

class TonoFlager extends GetxController {
  RxBool isStateVisible = false.obs; // 控制工具栏的显示状态
  var state = LoadingState.loading.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool paging = true.obs;
}
