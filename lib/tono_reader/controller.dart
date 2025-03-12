import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/model/base/tono_book_info.dart';
import 'package:voidlord/tono_reader/model/base/tono_type.dart';
import 'package:voidlord/tono_reader/parser/tono_parser.dart';
import 'package:voidlord/tono_reader/render/tono_font_loader.dart';
import 'package:voidlord/tono_reader/render/tono_render.dart';
import 'package:voidlord/utils/type.dart';

class TonoReaderController extends GetxController {
  TonoReaderController({
    required this.filePath,
    required this.tonoType,
  });

  RxBool isStateVisible = true.obs; // 控制工具栏的显示状态
  var state = LoadingState.loading.obs;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Tono? tono;

  TonoRender? render;

  List<TonoNavItem> navList = [];

  var current = 0.obs;

  List<Widget> currentWidgets = [];

  changeChapter(String id) async {
    state.value = LoadingState.loading;
    var c = await render!.rendeById(id);
    currentWidgets.clear();
    currentWidgets.addAll(c);
    state.value = LoadingState.success;
  }

  ///初始化部分

  final String filePath;
  final TonoType tonoType;

  void onBodyClick() {
    isStateVisible.toggle();
  }

  void openNavDrawer() async {
    showModalBottomSheet(
        context: Get.context!,
        builder: (ctx) {
          return BottomSheet(
              onClosing: () {},
              builder: (ctx) {
                return Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: Get.mediaQuery.size.height / 2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.dataset,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "章节",
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              Row(
                                children: [],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: navList.length,
                                itemBuilder: (ctx, index) {
                                  return Row(
                                    children: [
                                      Expanded(
                                          child: TextButton(
                                        style: TextButton.styleFrom(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(left: 20)),
                                        child: Text(
                                          navList[index].title,
                                          style: TextStyle(color: Colors.black),
                                          maxLines: 1,
                                        ),
                                        onPressed: () {
                                          changeChapter(navList[index].path);
                                        },
                                      )),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ));
              });
        });
  }

  void loadConfig() async {
    Get.put(TonoReaderConfig());
  }

  Future init() async {
    await Future.delayed(Duration(milliseconds: 500));
    loadConfig();
    if (tonoType == TonoType.local) {
      tono = await _initFromDisk();
      render = tono!.genRender();
      render?.loadFont();
      navList.addAll(tono!.navItems);
      var c = await render!.rendeById(navList[current.value].path);
      currentWidgets.clear();
      currentWidgets.addAll(c);
      state.value = LoadingState.success;
    }
    if (tonoType == TonoType.net) {
      _initFromNet();
      throw UnimplementedError();
    }
  }

  @override
  void onReady() {
    init();
    super.onReady();
  }

  Future<Tono> _initFromDisk() async {
    var tonoParse = await TonoParser.initFormDisk(filePath);
    return await tonoParse.parse();
  }

  _initFromNet() {}
}
