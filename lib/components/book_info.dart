import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:voidlord/model/book_info.dart';
import 'package:voidlord/routes/void_routers.dart';

class BookInfo extends StatelessWidget {
  const BookInfo({
    super.key,
    required this.bookInfoModel,
    required this.image,
  });
  final BookInfoModel bookInfoModel;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PhysicalModel(
            elevation: 1,
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
            child: SizedBox(
                width: 110,
                height: 160,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      VoidRouters.bookInfoPage,
                      arguments: bookInfoModel,
                    );
                  },
                  child: Hero(
                      tag: bookInfoModel.id,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8), // 圆角裁剪
                          child: image)),
                ))),
        const SizedBox(height: 8),
        SizedBox(
          width: 110,
          child: Text(
            bookInfoModel.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (bookInfoModel.subTitle != null)
          SizedBox(
            width: 110,
            child: Text(
              bookInfoModel.subTitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
        if (bookInfoModel.ssubTitle != null)
          SizedBox(
            width: 110,
            child: Text(
              bookInfoModel.ssubTitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
      ],
    );
  }
}
