import 'package:dio/dio.dart';

var baseUrl = "http://192.168.1.10:4523/m1/5806209-5491243-default";

class Api {
  final Dio client = Dio();
  Api() {
    client.options.baseUrl = baseUrl;
  }
}
