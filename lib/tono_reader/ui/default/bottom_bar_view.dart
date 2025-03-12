import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({
    super.key,
    required this.onMenuBtnPress,
  });

  final Function onMenuBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Get.theme.colorScheme.surfaceContainer,
      child: Column(
        children: [
          IconButton(
              onPressed: () {
                onMenuBtnPress();
              },
              icon: Icon(Icons.menu))
        ],
      ),
    );
  }
}
