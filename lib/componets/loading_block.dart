import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBlock extends StatelessWidget {
  const LoadingBlock({super.key, required this.height});
  final double height;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white54,
        highlightColor: Colors.grey,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: height,
            color: Colors.grey,
          ),
        ));
  }
}
