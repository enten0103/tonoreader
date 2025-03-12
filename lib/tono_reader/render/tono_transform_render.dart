import 'package:flutter/widgets.dart';

class TransformParser extends StatelessWidget {
  final String transform; // transform 属性字符串，如 "matrix(1, 0, 0, 1, 0, 0)"
  final String transformOrigin; // transform-origin 属性字符串，如 "center"
  final Widget child; // 要应用变换的子组件

  const TransformParser({
    super.key,
    required this.transform,
    required this.transformOrigin,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // 解析 transform 字符串
    final matrixValues = _parseTransform(transform);
    if (matrixValues == null) {
      return child; // 解析失败时直接返回子组件
    }

    // 解析 transform-origin
    final alignment = _parseTransformOrigin(transformOrigin);

    // 构建 Matrix4 矩阵
    final matrix = Matrix4(
      matrixValues[0], matrixValues[1], 0, 0, // a, c, 0, e
      matrixValues[2], matrixValues[3], 0, 0, // b, d, 0, f
      0, 0, 1, 0, // 保持 Z 轴不变
      matrixValues[4], matrixValues[5], 0, 1, // 保持齐次坐标
    );

    // 返回应用了变换的组件
    return Transform(
      alignment: alignment,
      transform: matrix,
      child: child,
    );
  }

  /// 解析 transform 字符串，如 "matrix(1, 0, 0, 1, 0, 0)"
  List<double>? _parseTransform(String transform) {
    final regex = RegExp(
        r'matrix\(([^,]+),\s*([^,]+),\s*([^,]+),\s*([^,]+),\s*([^,]+),\s*([^,]+)\)');
    final match = regex.firstMatch(transform);
    if (match == null) return null;

    try {
      final values = match
          .groups([1, 2, 3, 4, 5, 6])
          .map((e) => double.parse(e!))
          .toList();
      return values; // 返回 [a, b, c, d, e, f]
    } catch (e) {
      return null; // 解析失败返回 null
    }
  }

  /// 解析 transform-origin 字符串，如 "center"、"top left"
  Alignment _parseTransformOrigin(String origin) {
    switch (origin.trim()) {
      case 'center':
        return Alignment.center;
      case 'top left':
        return Alignment.topLeft;
      case 'top right':
        return Alignment.topRight;
      case 'bottom left':
        return Alignment.bottomLeft;
      case 'bottom right':
        return Alignment.bottomRight;
      default:
        return Alignment.center; // 默认使用 center
    }
  }
}
