import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/model/base/tono_type.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/render/widget/tono_container_widget.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/state/tono_flager.dart';
import 'package:voidlord/tono_reader/state/tono_initializer.dart';
import 'package:voidlord/tono_reader/state/tono_progresser.dart';
import 'package:voidlord/tono_reader/tool/nav_darwer.dart';
import 'package:voidlord/tono_reader/tool/tono_serializer.dart';
import 'package:voidlord/utils/type.dart';

class TonoReaderController extends GetxController {
  TonoReaderController({
    required this.id,
    required this.tonoType,
  });

  final String id;
  final TonoType tonoType;

  late TonoFlager tonoFlager = Get.find<TonoFlager>();
  late TonoProgresser tonoProgresser = Get.find<TonoProgresser>();
  late TonoProvider tonoDataProvider = Get.find<TonoProvider>();

  void changeChapter(String id) async {
    tonoFlager.state.value = LoadingState.loading;
    tonoFlager.state.value = LoadingState.success;
  }

  void siblingChapter(TapDownDetails details) async {
    tonoFlager.state.value = LoadingState.loading;
    tonoFlager.state.value = LoadingState.success;
  }

  void onBodyClick() {}

  void openNavDrawer() {
    NavDarwer.openNavDrawer();
  }

  Future<Widget> getWidgetByIndex(int index) async {
    index++;
    var tonoProgresser = Get.find<TonoProgresser>();
    var pageSequence = tonoProgresser.pageSequence;
    var xhtmlIndex = 0;
    while (index > pageSequence[xhtmlIndex]) {
      index -= pageSequence[xhtmlIndex];
      xhtmlIndex++;
    }
    var xhtmlId = tonoDataProvider.xhtmls[xhtmlIndex];
    return TonoContainerWidget(
        pageIndex: index,
        tonoContainer:
            await tonoDataProvider.getWidgetById(xhtmlId) as TonoContainer);
  }

  Future init() async {
    if (tonoType == TonoType.local) {
      var tono = await _initFromDisk();
      await TonoInitializer.init(tono);
      tonoFlager.state.value = LoadingState.success;
    }
    if (tonoType == TonoType.net) {
      _initFromNet();
      throw UnimplementedError();
    }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<Tono> _initFromDisk() async {
    return TonoSerializer.deserialize(id);
  }

  _initFromNet() {}
}
