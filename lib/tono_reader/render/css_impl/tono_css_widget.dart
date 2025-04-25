import 'package:flutter/widgets.dart';
import 'package:voidlord/tono_reader/render/css_parse/tono_css_converter.dart';
import 'package:voidlord/tono_reader/render/state/tono_container_provider.dart';

abstract class TonoCssWidget extends StatelessWidget with FlutterCssMixin {
  TonoCssWidget({super.key});

  Widget content(BuildContext context);

  @override
  Widget build(BuildContext context) {
    flutterStyleMap = context.fcm;
    return content(context);
  }
}
