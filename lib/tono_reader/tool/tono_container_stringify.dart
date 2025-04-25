import 'package:voidlord/tono_reader/model/widget/tono_container.dart';
import 'package:voidlord/tono_reader/model/widget/tono_text.dart';
import 'package:voidlord/tono_reader/model/widget/tono_widget.dart';

extension TonoContainerStringify on TonoWidget {
  String stringify() {
    if (this is TonoText) {
      return (this as TonoText).text;
    } else if (this is TonoContainer) {
      String result = "";
      for (var child in (this as TonoContainer).children) {
        result += child.stringify();
      }
      return result;
    } else {
      return "";
    }
  }
}
