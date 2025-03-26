import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/model/base/tono_type.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/tono_reader/render/widget/tono_container_widget.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/state/tono_flager.dart';
import 'package:voidlord/tono_reader/state/tono_initializer.dart';
import 'package:voidlord/tono_reader/state/tono_progresser.dart';
import 'package:voidlord/tono_reader/tool/nav_darwer.dart';
import 'package:voidlord/utils/type.dart';

class TonoReaderController extends GetxController {
  TonoReaderController({
    required this.filePath,
    required this.tonoType,
  });

  final String filePath;
  final TonoType tonoType;
  Widget currentWidget = Text("loading");

  late TonoFlager tonoFlager = Get.find<TonoFlager>();
  late TonoProgresser tonoProgresser = Get.find<TonoProgresser>();
  late TonoProvider tonoDataProvider = Get.find<TonoProvider>();

  void changeChapter(String id) async {
    tonoFlager.state.value = LoadingState.loading;
    currentWidget = TonoContainerWidget(
      tonoContainer: await tonoDataProvider.getWidgetById(id) as TonoContainer,
    );
    tonoProgresser.xhtmlIndex = tonoDataProvider.xhtmls.indexOf(id);
    tonoFlager.state.value = LoadingState.success;
  }

  void siblingChapter(TapDownDetails details) async {
    tonoFlager.state.value = LoadingState.loading;
    try {
      if (details.localPosition.dx > Get.mediaQuery.size.width / 2) {
        var key = tonoDataProvider.xhtmls[tonoProgresser.xhtmlIndex + 1];
        currentWidget = TonoContainerWidget(
          tonoContainer:
              await tonoDataProvider.getWidgetById(key) as TonoContainer,
        );
        tonoProgresser.xhtmlIndex++;
      } else {
        var key = tonoDataProvider.xhtmls[tonoProgresser.xhtmlIndex - 1];
        currentWidget = TonoContainerWidget(
          tonoContainer:
              await tonoDataProvider.getWidgetById(key) as TonoContainer,
        );
        tonoProgresser.xhtmlIndex--;
      }
    } catch (_) {}
    tonoFlager.state.value = LoadingState.success;
  }

  void onBodyClick() {
    tonoFlager.isStateVisible.toggle();
  }

  void openNavDrawer() {
    NavDarwer.openNavDrawer();
  }

  Future init() async {
    await Future.delayed(Duration(milliseconds: 500));
    if (tonoType == TonoType.local) {
      var tono = await _initFromDisk();
      await TonoInitializer.init(tono);
      changeChapter(tono.navItems[0].path);
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
    var tonoParse = await TonoParser.initFormDisk(filePath);
    return await tonoParse.parse();
  }

  _initFromNet() {}
}
