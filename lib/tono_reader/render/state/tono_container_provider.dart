import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/state_manager.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

class TonoContainerProvider extends InheritedWidget {
  const TonoContainerProvider({
    super.key,
    required this.data,
    required super.child,
    required this.fcm,
    required this.parentSize,
  });

  final TonoWidget data;
  final Rx<Size?> parentSize;
  final Map<String, dynamic> fcm;

  static TonoContainerProvider of(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<TonoContainerProvider>()!
        .widget as TonoContainerProvider;
  }

  @override
  bool updateShouldNotify(TonoContainerProvider old) {
    return old.data != data;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(
      DiagnosticsProperty("css", data.css),
    );
    properties.add(
      DiagnosticsProperty("fcm", fcm),
    );

    super.debugFillProperties(properties);
  }
}

extension ContainerGetter on BuildContext {
  TonoWidget get tonoWidget => TonoContainerProvider.of(this).data;
  Rx<Size?>? get parentSize => TonoContainerProvider.of(this).parentSize;
  Map<String, dynamic> get fcm => TonoContainerProvider.of(this).fcm;
}
