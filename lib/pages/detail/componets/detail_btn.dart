import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DetailBtn extends StatelessWidget {
  const DetailBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child: OutlinedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
          ),
          child: SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "下载",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ))),
        )),
        SizedBox(
          height: 20,
          width: 20,
        ),
        Expanded(
            child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Get.theme.colorScheme.primary,
          ),
          child: SizedBox(
              height: 50,
              child: Center(
                  child: Text(
                "阅读",
                style: TextStyle(
                    color: Get.theme.colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))),
        )),
      ],
    );
  }
}
