import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class AfterLayout extends SingleChildRenderObjectWidget {
  const AfterLayout({
    super.key,
    required this.callback,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderAfterLayout(callback);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderAfterLayout renderObject) {
    renderObject.callback = callback;
  }

  final ValueSetter<RenderAfterLayout> callback;
}

class RenderAfterLayout extends RenderProxyBox {
  RenderAfterLayout(this.callback);

  ValueSetter<RenderAfterLayout> callback;

  @override
  void performLayout() {
    super.performLayout();
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => callback(this));
  }

  Offset get offset => localToGlobal(Offset.zero);

  Rect get rect => offset & size;
}
