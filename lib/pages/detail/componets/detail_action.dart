import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:voidlord/pages/detail/controller.dart';
import 'package:voidlord/utils/type.dart';

class DetailAction extends StatelessWidget {
  const DetailAction({super.key, required this.controller, this.onTap});

  final BookDetailController controller;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loadingState.value != LoadingState.success) {
        return IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.bookmark_add_outlined,
              size: 30,
            ));
      }
      if (controller.bookDetailModel.statistics?.hasCollected ?? false) {
        return IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.bookmark_add_outlined,
              size: 30,
            ));
      } else {
        return IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.bookmark_added,
              size: 30,
            ));
      }
    });
  }
}
