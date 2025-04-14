import 'dart:ui';
import 'package:flutter/material.dart';

// 样式枚举
enum BorderCustomStyle { solid, dashed, dotted }

// 组合式边框边定义
class StyledBorderSide extends BorderSide {
  final BorderCustomStyle borderStyle;

  const StyledBorderSide({
    super.color,
    super.width,
    this.borderStyle = BorderCustomStyle.solid,
  });

  @override
  StyledBorderSide scale(double t) => StyledBorderSide(
        borderStyle: borderStyle,
      );
}

class StyledBorder extends BoxBorder {
  @override
  final StyledBorderSide top;

  @override
  final StyledBorderSide bottom;
  final StyledBorderSide left;
  final StyledBorderSide right;
  final List<double> dashPattern;
  final double dotRadius;
  final double dotSpacing;

  const StyledBorder({
    this.top = const StyledBorderSide(width: 0),
    this.bottom = const StyledBorderSide(width: 0),
    this.left = const StyledBorderSide(width: 0),
    this.right = const StyledBorderSide(width: 0),
    this.dashPattern = const [3, 1],
    this.dotRadius = 1.0,
    this.dotSpacing = 3.0,
  })  : assert(dashPattern.length == 2, 'dashPattern requires two values'),
        assert(dotRadius >= 0, 'dotRadius must be non-negative'),
        assert(dotSpacing >= 0, 'dotSpacing must be non-negative');

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.fromLTRB(
        left.width,
        top.width,
        right.width,
        bottom.width,
      );

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    if (shape == BoxShape.rectangle && borderRadius == null) {
      _paintRectangularBorder(canvas, rect);
    } else {
      _paintComplexShapeBorder(canvas, rect, shape, borderRadius);
    }
  }

  // 核心绘制方法实现
  void _paintPathAccordingToStyle(
    Canvas canvas,
    Path path,
    StyledBorderSide styledSide,
  ) {
    if (styledSide.width == 0) return;

    switch (styledSide.borderStyle) {
      case BorderCustomStyle.dashed:
        final Paint paint = Paint()
          ..color = styledSide.color
          ..strokeWidth = styledSide.width
          ..style = PaintingStyle.stroke;
        canvas.drawPath(_generateDashedPath(path), paint);
        break;

      case BorderCustomStyle.dotted:
        final Paint paint = Paint()..color = styledSide.color;
        final PathMetrics metrics = path.computeMetrics();
        final double step = (dotRadius * 2) + dotSpacing;

        for (final PathMetric metric in metrics) {
          double distance = 0;
          while (distance < metric.length) {
            final Tangent? tangent = metric.getTangentForOffset(distance);
            if (tangent != null) {
              canvas.drawCircle(
                tangent.position,
                dotRadius,
                paint..strokeWidth = styledSide.width,
              );
            }
            distance += step;
          }
        }
        break;

      default: // solid
        final Paint paint = Paint()
          ..color = styledSide.color
          ..strokeWidth = styledSide.width
          ..style = PaintingStyle.stroke;
        canvas.drawPath(path, paint);
    }
  }

  // 其他辅助方法
  Path _generateDashedPath(Path path) {
    final Path dashedPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        dashedPath.addPath(
          metric.extractPath(distance, distance + dashPattern[0]),
          Offset.zero,
        );
        distance += dashPattern[0] + dashPattern[1];
      }
    }
    return dashedPath;
  }

  // 矩形边框绘制
  void _paintRectangularBorder(Canvas canvas, Rect rect) {
    _paintEdge(canvas, rect.topLeft, rect.topRight, top);
    _paintEdge(canvas, rect.bottomLeft, rect.bottomRight, bottom);
    _paintEdge(canvas, rect.topLeft, rect.bottomLeft, left);
    _paintEdge(canvas, rect.topRight, rect.bottomRight, right);
  }

  void _paintEdge(
      Canvas canvas, Offset start, Offset end, StyledBorderSide side) {
    if (side.width == 0) return;

    final Path path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);

    _paintPathAccordingToStyle(canvas, path, side);
  }

  // 复杂形状绘制
  void _paintComplexShapeBorder(
    Canvas canvas,
    Rect rect,
    BoxShape shape,
    BorderRadius? borderRadius,
  ) {
    if (shape == BoxShape.rectangle) {
      final RRect rrect = borderRadius!.toRRect(rect);
      _paintEdgeWithRRect(canvas, rrect, top, _EdgeSide.top);
      _paintEdgeWithRRect(canvas, rrect, right, _EdgeSide.right);
      _paintEdgeWithRRect(canvas, rrect, bottom, _EdgeSide.bottom);
      _paintEdgeWithRRect(canvas, rrect, left, _EdgeSide.left);
    } else {
      final path = Path()..addOval(rect);
      _paintPathAccordingToStyle(canvas, path, _selectDominantSide());
    }
  }

  void _paintEdgeWithRRect(
      Canvas canvas, RRect rrect, StyledBorderSide side, _EdgeSide edge) {
    if (side.width == 0) return;

    final path = _getEdgePath(rrect, edge);
    _paintPathAccordingToStyle(canvas, path, side);
  }

  Path _getEdgePath(RRect rrect, _EdgeSide edge) {
    final path = Path();
    switch (edge) {
      case _EdgeSide.top:
        path.moveTo(
            rrect.tlRadiusX > 0 ? rrect.left + rrect.tlRadiusX : rrect.left,
            rrect.top);
        path.lineTo(rrect.right - (rrect.trRadiusX > 0 ? rrect.trRadiusX : 0),
            rrect.top);
        break;
      case _EdgeSide.right:
        path.moveTo(rrect.right,
            rrect.top + (rrect.trRadiusY > 0 ? rrect.trRadiusY : 0));
        path.lineTo(rrect.right,
            rrect.bottom - (rrect.brRadiusY > 0 ? rrect.brRadiusY : 0));
        break;
      case _EdgeSide.bottom:
        path.moveTo(rrect.right - (rrect.brRadiusX > 0 ? rrect.brRadiusX : 0),
            rrect.bottom);
        path.lineTo(rrect.left + (rrect.blRadiusX > 0 ? rrect.blRadiusX : 0),
            rrect.bottom);
        break;
      case _EdgeSide.left:
        path.moveTo(rrect.left,
            rrect.bottom - (rrect.blRadiusY > 0 ? rrect.blRadiusY : 0));
        path.lineTo(rrect.left,
            rrect.top + (rrect.tlRadiusY > 0 ? rrect.tlRadiusY : 0));
        break;
    }
    return path;
  }

  // 选择主导边（用于圆形边框）
  StyledBorderSide _selectDominantSide() {
    final sides = [top, right, bottom, left];
    return sides.firstWhere(
      (side) => side.width != 0,
      orElse: () => const StyledBorderSide(width: 0),
    );
  }

  @override
  bool get isUniform => top == right && right == bottom && bottom == left;

  @override
  StyledBorder scale(double t) => StyledBorder(
        top: top.scale(t),
        bottom: bottom.scale(t),
        left: left.scale(t),
        right: right.scale(t),
        dashPattern: [dashPattern[0] * t, dashPattern[1] * t],
        dotRadius: dotRadius * t,
        dotSpacing: dotSpacing * t,
      );
}

enum _EdgeSide { top, right, bottom, left }
