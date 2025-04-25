import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TonoLayoutProvider extends InheritedWidget {
  const TonoLayoutProvider({
    super.key,
    required this.index,
    required super.child,
  });

  final int index;

  static TonoLayoutProvider of(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<TonoLayoutProvider>()!
        .widget as TonoLayoutProvider;
  }

  @override
  bool updateShouldNotify(TonoLayoutProvider old) {
    return old.index != index;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
      DiagnosticsProperty("index", index),
    );

    super.debugFillProperties(properties);
  }
}

extension ContainerGetter on BuildContext {
  get tonoLayoutType => TonoLayoutProvider.of(this).index;
}
