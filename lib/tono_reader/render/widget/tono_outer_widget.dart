import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:voidlord/tono_reader/config.dart';
import 'package:voidlord/tono_reader/controller.dart';
import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/render/css_impl/tono_css_transform_widget.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_provider.dart';
import 'package:voidlord/tono_reader/render/css_impl/tono_css_margin_widget.dart';
import 'package:voidlord/tono_reader/render/css_impl/tono_css_size_padding_widget.dart';
import 'package:voidlord/tono_reader/render/state/tono_layout_provider.dart';
import 'package:voidlord/tono_reader/render/state/tono_parent_size_cache.dart';
import 'package:voidlord/tono_reader/render/widget/tono_container_widget.dart';
import 'package:voidlord/tono_reader/state/tono_data_provider.dart';
import 'package:voidlord/tono_reader/state/tono_progresser.dart';
import 'package:voidlord/tono_reader/ui/default/op_dialog_view.dart';

///
/// body+html元素渲染
/// 实现滚动逻辑
/// 根容器渲染
/// bg相关暂不实现
///
/// 根元素不进行transform,无 [TonoCssTransform] 渲染
class TonoOuterWidget extends StatelessWidget {
  /// 根元素
  final TonoContainer root;

  TonoOuterWidget({
    super.key,
    required this.root,
  }) : assert(
          root.className == "html" &&
              root.children.length == 1 &&
              root.children[0].className == "body",
          "根元素dom结构应为 html-> body->...",
        );

  @override
  Widget build(BuildContext context) {
    var provider = Get.find<TonoProvider>()..initSliderProgressor();
    var progressor = Get.find<TonoProgresser>();
    var controller = Get.find<TonoReaderController>();
    controller.itemPositionsListener.itemPositions.addListener(() {
      var positions = controller.itemPositionsListener.itemPositions.value;
      progressor.currentElementIndex.value = positions.last.index;
    });
    return TonoLayoutProvider(
        type: TonoLayoutType.fix,
        child: TonoSingleElementWidget(
            element: root,
            child: TonoSingleElementWidget(
                element: root.children[0] as TonoContainer,
                child: ScrollablePositionedList.separated(
                    key: controller.scrollKey,
                    addAutomaticKeepAlives: true,
                    itemScrollController: controller.itemScrollController,
                    itemPositionsListener: controller.itemPositionsListener,
                    minCacheExtent: 100,
                    itemCount: progressor.totalElementCount,
                    separatorBuilder: (context, index) {
                      var result = provider.isLast(index);
                      if (result) {
                        return SizedBox(
                          height: Get.mediaQuery.size.height / 3,
                        );
                      } else {
                        return Container();
                      }
                    },
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                          onLongPress: () =>
                              Get.dialog(OpDialogView(index: index)),
                          child: TonoContainerWidget(
                              key: ValueKey(index),
                              tonoContainer:
                                  provider.getWidgetByElementCount(index)
                                      as TonoContainer));
                    }))));
  }
}

class TonoSingleElementWidget extends StatelessWidget {
  const TonoSingleElementWidget({
    super.key,
    required this.element,
    required this.child,
  });

  final TonoContainer element;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var cache = Get.find<TonoParentSizeCache>();
    try {
      var fcm = FlutterStyleFromCss(
        element.css,
        pdisplay: element.parent?.display,
        tdisplay: element.display,
        parentSize: element.className == "html"
            ? genContainerSize()
            : cache.getSize(element.hashCode) ?? context.parentSize?.value,
      ).flutterStyleMap;
      return TonoContainerProvider(
        fcm: fcm,
        parentSize: Rx(null),
        data: element,
        child: TonoCssTransformWidget(
            child: TonoCssMarginWidget(
          child: TonoCssSizePaddingWidget(child: child),
        )),
      );
    } on NeedParentSizeException catch (_) {
      return Obx(() {
        var parentSize = context.parentSize;
        if (parentSize?.value == null) {
          return SizedBox.expand();
        } else {
          cache.setSize(element.hashCode, parentSize!.value!);
          var fcm = FlutterStyleFromCss(
            pdisplay: element.parent?.display,
            element.css,
            tdisplay: element.display,
            parentSize: parentSize.value,
          ).flutterStyleMap;

          return TonoContainerProvider(
            fcm: fcm,
            parentSize: Rx(parentSize.value),
            data: element,
            child: TonoCssTransformWidget(
                child: TonoCssMarginWidget(
              child: TonoCssSizePaddingWidget(child: child),
            )),
          );
        }
      });
    }
  }

  Size genContainerSize() {
    var config = Get.find<TonoReaderConfig>();
    var padding = Get.mediaQuery.padding;
    var screenSize = Get.mediaQuery.size;
    return Size(
        screenSize.width -
            padding.left -
            padding.right -
            config.viewPortConfig.left -
            config.viewPortConfig.right,
        screenSize.height -
            padding.top -
            padding.bottom -
            config.viewPortConfig.top -
            config.viewPortConfig.bottom);
  }
}
