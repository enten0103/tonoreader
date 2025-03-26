import 'package:flutter/material.dart';
import 'package:voidlord/tono_reader/tool/box_decoration.dart';
import 'package:voidlord/tono_reader/tool/constained_row.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: ConstrainedRow(
              children: [
                Container(
                  width: 300,
                  height: 200,
                  decoration: TonoBoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: TonoDecorationImage(
                      image: NetworkImage(
                          'https://picx.zhimg.com/70/v2-148f2762190be75bf4090f8dcdd9e4c7_1440w.image?source=172ae18b&biz_tag=Post'),
                      size: BackgroundSize(
                        widthMode: BackgroundSizeMode.percentage,
                        heightMode: BackgroundSizeMode.percentage,
                        widthValue: 0.5,
                        heightValue: 1,
                      ), // 80% 宽，60% 高
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  child: Text("112"),
                )
              ],
            )));
  }
}
