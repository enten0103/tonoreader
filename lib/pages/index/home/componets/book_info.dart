import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:voidlord/pages/index/home/module.dart';
import 'package:voidlord/utils/keep_alive_warpper.dart';

class BookInfo extends StatelessWidget {
  const BookInfo({super.key, required this.bookInfoModule});

  final BookInfoModule bookInfoModule;

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PhysicalModel(
            elevation: 1,
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
            child: SizedBox(
              width: 110,
              height: 160,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // 圆角裁剪
                  child: CachedNetworkImage(
                    imageUrl: bookInfoModule.coverUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )),
            )),
        const SizedBox(height: 8),
        SizedBox(
          width: 100, // 保持与图片同宽
          child: Text(
            bookInfoModule.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (bookInfoModule.authorName != null)
          SizedBox(
            width: 100,
            child: Text(
              bookInfoModule.authorName!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ),
      ],
    ));
  }
}
