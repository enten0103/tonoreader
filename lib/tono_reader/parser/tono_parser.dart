import 'package:voidlord/tono_reader/data_provider/local_data_provider.dart';
import 'package:voidlord/tono_reader/data_provider/tono_data_provider.dart';
import 'package:voidlord/tono_reader/model/base/tono.dart';
import 'package:voidlord/tono_reader/parser/tono_opf_parser.dart';
import 'package:voidlord/tono_reader/parser/tono_parse_event.dart';

///tono解析器
///解析epub文件为tono文件
class TonoParser {
  TonoParser({
    required this.onStateChange,
  });
  late TonoDataProvider provider;

  void Function(TonoParseEvent) onStateChange;

  Future<Tono> parse() async {
    return await parseOpf();
  }

  static Future<TonoParser> initFormDisk(
    String filePath,
    void Function(TonoParseEvent) onStateChange,
  ) async {
    var provider = LocalDataProvider(root: filePath);
    var tp = TonoParser(onStateChange: onStateChange);
    await provider.init();
    tp.provider = provider;
    return tp;
  }
}
