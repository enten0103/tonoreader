import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookCover extends StatelessWidget {
  const BookCover({super.key, required this.id, required this.url});
  final String id;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: PhysicalModel(
            elevation: 1,
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
            child: Container(
              constraints: BoxConstraints(maxWidth: 110),
              height: 160,
              child: Hero(
                  tag: id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // 圆角裁剪
                    child: url.startsWith("http")
                        ? CachedNetworkImage(
                            imageUrl: url,
                            fadeInDuration: Duration(microseconds: 0),
                            fadeOutDuration: Duration(microseconds: 0),
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : Image.file(
                            File(url),
                            fit: BoxFit.cover,
                          ),
                  )),
            )));
  }
}
