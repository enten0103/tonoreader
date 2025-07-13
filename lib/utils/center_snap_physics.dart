import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

class CenterSnapPhysics extends ScrollPhysics {
  const CenterSnapPhysics({super.parent});

  @override
  CenterSnapPhysics applyTo(ScrollPhysics? ancestor) {
    return CenterSnapPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // 计算吸附位置（屏幕中心）
    final double scrollOffset = position.pixels;
    final double itemWidth = Get.size.width * 0.8; // 子项宽度

    // 计算最近子项的中心偏移量
    double targetOffset =
        (((scrollOffset) / itemWidth).roundToDouble()) * itemWidth;

    // 确保边界安全
    targetOffset = targetOffset.clamp(0.0, position.maxScrollExtent);

    return ScrollSpringSimulation(
      SpringDescription(mass: 1, stiffness: 500, damping: 30),
      scrollOffset,
      targetOffset,
      velocity,
      tolerance: toleranceFor(position),
    );
  }
}
