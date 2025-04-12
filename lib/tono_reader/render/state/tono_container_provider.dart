import 'package:flutter/cupertino.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class TonoContainerProvider extends InheritedWidget {
  const TonoContainerProvider({
    super.key,
    required this.data,
    required super.child,
  });

  final TonoWidget data;

  static TonoContainerProvider of(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<TonoContainerProvider>()!
        .widget as TonoContainerProvider;
  }

  @override
  bool updateShouldNotify(TonoContainerProvider old) {
    return old.data != data;
  }
}

extension ContainerGetter on BuildContext {
  TonoWidget get tonoWidget => TonoContainerProvider.of(this).data;
}
