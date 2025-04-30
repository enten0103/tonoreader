import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voidlord/tono_reader/state/tono_left_drawer_controller.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({
    super.key,
    required this.onMenuBtnPress,
  });

  final Function onMenuBtnPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(),
          IconButton(
              onPressed: () {
                Get.find<TonoLeftDrawerController>()
                    .scaffoldKey
                    .currentState
                    ?.openDrawer();
              },
              icon: Icon(Icons.menu)),
          IconButton(onPressed: () {}, icon: Icon(Icons.text_format)),
          IconButton(onPressed: () {}, icon: Icon(Icons.star_outline)),
          IconButton(onPressed: () {}, icon: Icon(Icons.light_mode_outlined)),
        ],
      ),
    );
  }
}
