import 'package:dio/dio.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:voidlord/controller/auth_controller.dart';

// 新后端基础地址（OpenAPI 来源 http://localhost:3000/api-json）
// 如需切换环境，可将此配置改为从持久化或构建环境读取。
var baseUrl = "http://192.168.1.103:3000";

class Api {
  final Dio client = Dio();
  Api() {
    client.options.baseUrl = baseUrl;
    client.options.validateStatus = (status) {
      return true;
    };
    client.interceptors.add(AuthInterceptor());
  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    AuthController authController = Get.find();
    final token = authController.token;
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
